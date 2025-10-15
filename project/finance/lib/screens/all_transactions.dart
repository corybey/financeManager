// ALL TRANSACTIONS MADE
// Data from sample data

import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Transactions')),
      //Scrollable list of all transactions
      body: ListView.builder(
        itemCount: sampleTransactions.length,
        // Get each transaction from sample data
        itemBuilder: (context, index) {
          final transaction = sampleTransactions[index];
          // Each transaction is displayed in a card with title, category, and amount
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(
                // Icon changes based on income or expense
                transaction['amount'] > 0
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: transaction['amount'] > 0 ? Colors.green : Colors.red,
              ),
              //Transaction title, category, and amount
              title: Text(transaction['title']),
              subtitle: Text(transaction['category']),
              trailing: Text(
                '\$${transaction['amount'].abs()}',
                style: TextStyle(
                  color: transaction['amount'] > 0 ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
