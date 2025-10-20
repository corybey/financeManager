// Lists transaction title and amount
// Used in all_transactions.dart

import 'package:flutter/material.dart';

/// A reusable ListTile for showing a transaction entry.
class TransactionTile extends StatelessWidget {
  final String title;
  final String category;
  final double amount;
  final String date;

  const TransactionTile({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        amount > 0 ? Icons.arrow_downward : Icons.arrow_upward,
        color: amount > 0 ? Colors.green : Colors.red,
      ),
      title: Text(title),
      subtitle: Text('$category • $date'),
      trailing: Text(
        '\$${amount.abs().toStringAsFixed(2)}',
        style: TextStyle(
          color: amount > 0 ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
