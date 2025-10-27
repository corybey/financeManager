// BASIC REPORTS AND CATEGORY BREAKDOWN

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../database/database_helper.dart';
import '../widgets/balance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  double _totalIncome = 0.0;
  double _totalExpenses = 0.0;
  double _totalSavings = 0.0;
  double _savingsGoal = 1000.0; // Default savings goal
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFinancialData();
  }

  Future<void> _loadFinancialData() async {
    try {
      final income = await _dbHelper.getTotalIncome();
      final transactionIncome = await _dbHelper.getTransactionIncome();
      final expenses = await _dbHelper.getTotalExpenses();
      final savings = await _dbHelper.getTotalSavings();

      // FORCE ZERO START - no preset values
      setState(() {
        _totalIncome = income + transactionIncome;
        _totalExpenses = expenses;
        _totalSavings = savings;
        _isLoading = false;
      });

      print('🔄 Financial Data Updated:');
      print('   - Income: $_totalIncome');
      print('   - Expenses: $_totalExpenses');
      print('   - Balance: ${_totalIncome - _totalExpenses}');
      print('   - Savings: $_totalSavings');
    } catch (e) {
      print('❌ Error in _loadFinancialData: $e');
      // Force all values to zero on error
      setState(() {
        _totalIncome = 0.0;
        _totalExpenses = 0.0;
        _totalSavings = 0.0;
        _isLoading = false;
      });
    }
  }

  double get _progressValue {
    if (_savingsGoal == 0) return 0.0;
    final progress = _totalSavings / _savingsGoal;
    return progress > 1.0 ? 1.0 : progress;
  }

  bool get _isGoalReached {
    return _totalSavings >= _savingsGoal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Finance Manager'),
        actions: [
          IconButton(
            icon: Icon(
              _isGoalReached
                  ? Icons.notifications_active
                  : Icons.notifications_none,
              color: _isGoalReached ? Colors.amber : Colors.grey[600],
            ),
            onPressed: () {
              if (_isGoalReached) {
                _showGoalReachedDialog();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'You\'re ${(_progressValue * 100).toStringAsFixed(1)}% of the way to your goal!',
                    ),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFinancialData,
          ),
        ],
      ),

      // Drawer menu (Options tab)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Options',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Log Income'),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, '/log_income');
                _loadFinancialData(); // Refresh data after returning
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle),
              title: const Text('Log Transactions'),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, '/log_transactions');
                _loadFinancialData(); // Refresh data after returning
              },
            ),
            ListTile(
              leading: const Icon(Icons.savings),
              title: const Text('Log Savings'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.pushNamed(
                  context,
                  '/log_savings',
                );
                if (result != null && result is double) {
                  _loadFinancialData(); // Refresh data with new savings

                  // Auto-notify if goal is reached
                  if (_isGoalReached) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showGoalReachedDialog();
                    });
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('All Transactions'),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, '/all_transactions');
                _loadFinancialData(); // Refresh data after returning
              },
            ),
          ],
        ),
      ),

      // Main content
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display total balance card
                  const BalanceWidget(),
                  const SizedBox(height: 20),

                  // Pie Chart
                  Row(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: PieChart(
                          PieChartData(
                            sections: _buildPieChartSections(),
                            centerSpaceRadius: 40,
                            sectionsSpace: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LegendItem(
                            color: Colors.blue,
                            text:
                                'Savings: \$${_totalSavings.toStringAsFixed(2)}',
                          ),
                          _LegendItem(
                            color: Colors.green,
                            text:
                                'Income: \$${_totalIncome.toStringAsFixed(2)}',
                          ),
                          _LegendItem(
                            color: Colors.red,
                            text:
                                'Expenses: \$${_totalExpenses.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Savings Goal Progress Bar
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Savings Goal: \$1,000.00',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: _progressValue,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isGoalReached ? Colors.green : Colors.blue,
                    ),
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Saved: \$${_totalSavings.toStringAsFixed(2)} / \$${_savingsGoal.toStringAsFixed(2)} (${(_progressValue * 100).toStringAsFixed(1)}%)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final total = _totalIncome + _totalExpenses + _totalSavings;
    if (total == 0) {
      return [
        PieChartSectionData(
          value: 1,
          title: 'No Data',
          color: Colors.grey,
          radius: 80,
        ),
      ];
    }

    return [
      PieChartSectionData(
        value: _totalSavings,
        title: '',
        color: Colors.blue,
        radius: 80,
      ),
      PieChartSectionData(
        value: _totalIncome,
        title: '',
        color: Colors.green,
        radius: 80,
      ),
      PieChartSectionData(
        value: _totalExpenses,
        title: '',
        color: Colors.red,
        radius: 80,
      ),
    ];
  }

  void _showGoalReachedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Goal Reached! 🎉'),
        content: Text(
          'Congratulations! You\'ve reached your savings goal of \$${_savingsGoal.toStringAsFixed(2)}!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Awesome!'),
          ),
        ],
      ),
    );
  }
}

// Legend Widget (for Pie Chart labels)
class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(width: 14, height: 14, color: color),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
