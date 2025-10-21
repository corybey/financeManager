// SAVINGS GOALS

import 'package:flutter/material.dart';

class LogSavingsScreen extends StatelessWidget {
  const LogSavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController goalController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Log Savings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Amount To Your Goal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Amount input
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount Saved',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            // Goal name input (optional for now)
            TextField(
              controller: goalController,
              decoration: const InputDecoration(
                labelText: 'Goal Name',
                prefixIcon: Icon(Icons.flag),
              ),
            ),

            const SizedBox(height: 30),

            // Add Savings Button
            ElevatedButton.icon(
              icon: const Icon(Icons.savings),
              label: const Text('Add to Savings'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                final amount = double.tryParse(amountController.text);

                // Validate numeric input
                if (amount != null && amount > 0) {
                  // Send back the amount to HomeScreen
                  Navigator.pop(context, amount);
                } else {
                  // Show an error if user didn’t enter a valid number
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid savings amount.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
