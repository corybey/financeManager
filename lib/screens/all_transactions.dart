import 'package:flutter/material.dart';
import '../widgets/transaction_title.dart';
import '../database/database_helper.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  // Load all transactions from SQLite
  Future<void> _loadTransactions() async {
    final data = await DatabaseHelper().getTransactions();
    setState(() {
      _transactions = data;
    });
  }

  // Delete a specific transaction
  Future<void> _deleteTransaction(int id) async {
    await DatabaseHelper().deleteTransaction(id);
    _loadTransactions(); // refresh after deletion
  }

  // Clear all transactions with confirmation
  Future<void> _clearAllTransactions() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete All Transactions'),
        content: const Text('Are you sure you want to clear ALL transactions?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper().clearAllTransactions();
      _loadTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Clear All',
            onPressed: _clearAllTransactions,
          ),
        ],
      ),
      body: _transactions.isEmpty
          ? const Center(child: Text('No transactions found.'))
          : RefreshIndicator(
              onRefresh: _loadTransactions,
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return Dismissible(
                    key: Key(transaction['id'].toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => _deleteTransaction(transaction['id']),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: TransactionTile(
                        title: transaction['title'] ?? 'Untitled',
                        category: transaction['category'] ?? 'Other',
                        amount: transaction['amount'] ?? 0.0,
                        date: transaction['date'] ?? '',
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
