// INCOME AND EXPENSE SCREEN

import 'package:flutter/material.dart';

class LogTransactionsScreen extends StatelessWidget {
  const LogTransactionsScreen({super.key});

  @override
  //build inputs for amount and description
  Widget build(BuildContext context) {
    final _amountController = TextEditingController();
    final _descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Log Transactions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Save Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
