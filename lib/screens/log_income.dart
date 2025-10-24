// LOG INCOME SCREEN

import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/income.dart';

class LogIncomeScreen extends StatefulWidget {
  const LogIncomeScreen({super.key});

  @override
  State<LogIncomeScreen> createState() => _LogIncomeScreenState();
}

class _LogIncomeScreenState extends State<LogIncomeScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Income')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveIncome,
              child: const Text('Save Income'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveIncome() async {
    final amount = double.tryParse(_amountController.text);
    final description = _descriptionController.text.trim();

    if (amount == null || amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }

    try {
      final income = Income(
        amount: amount,
        description: description.isEmpty ? 'Income' : description,
        date: DateTime.now(),
      );

      await _dbHelper.insertIncome(income.toMap());
      
      // Clear form
      _amountController.clear();
      _descriptionController.clear();
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Income saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate back after a short delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pop(context);
      });
      
    } catch (e) {
      _showError('Failed to save income: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}