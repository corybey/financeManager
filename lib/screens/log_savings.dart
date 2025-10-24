// SAVINGS GOALS

import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/savings.dart';

class LogSavingsScreen extends StatefulWidget {
  const LogSavingsScreen({super.key});

  @override
  State<LogSavingsScreen> createState() => _LogSavingsScreenState();
}

class _LogSavingsScreenState extends State<LogSavingsScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController goalController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
              onPressed: _saveSavings,
            ),
          ],
        ),
      ),
    );
  }

  void _saveSavings() async {
    final amount = double.tryParse(amountController.text);
    final goalName = goalController.text.trim();

    // Validate numeric input
    if (amount != null && amount > 0) {
      try {
        final savings = Savings(
          amount: amount,
          goalName: goalName.isEmpty ? 'Savings Goal' : goalName,
          date: DateTime.now(),
        );

        await _dbHelper.insertSavings(savings.toMap());
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added \$${amount.toStringAsFixed(2)} to savings!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate back with the amount
        Navigator.pop(context, amount);
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save savings: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Show an error if user didn't enter a valid number
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid savings amount.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    goalController.dispose();
    super.dispose();
  }
}