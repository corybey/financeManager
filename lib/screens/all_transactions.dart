// ALL TRANSACTIONS MADE
// Data from sample data

import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../widgets/transaction_title.dart'; // ✅ Using widget now

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Transactions')),

      // ✅ Scrollable list using reusable widget
      body: ListView.builder(
        itemCount: sampleTransactions.length,
        itemBuilder: (context, index) {
          final transaction = sampleTransactions[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TransactionTile(
              title: transaction['title'],
              category: transaction['category'],
              amount: transaction['amount'],
              date: transaction['date'], // if you included date in sample_data
            ),
          );
        },
      ),
    );
  }
}
