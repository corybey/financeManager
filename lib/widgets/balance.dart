import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateBalance();
  }

  Future<void> _calculateBalance() async {
    try {
      final db = DatabaseHelper();
      final income = await db.getTotalIncome() + await db.getTransactionIncome();
      final expenses = await db.getTotalExpenses();
      setState(() {
        _balance = income - expenses;
      });
    } catch (e) {
      setState(() {
        _balance = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Total Balance', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text('\$${_balance.toStringAsFixed(2)}', 
                 style: TextStyle(fontSize: 32, color: _balance >= 0 ? Colors.green : Colors.red)),
          ],
        ),
      ),
    );
  }
}