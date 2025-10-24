// INCOME AND EXPENSE SCREEN

import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/transaction.dart';

class LogTransactionsScreen extends StatefulWidget {
  const LogTransactionsScreen({super.key});

  @override
  State<LogTransactionsScreen> createState() => _LogTransactionsScreenState();
}

class _LogTransactionsScreenState extends State<LogTransactionsScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Food';
  String _selectedType = 'expense';
  
  final List<String> _categories = [
    'Food', 'Transport', 'Entertainment', 'Shopping', 
    'Bills', 'Healthcare', 'Other'
  ];

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Transactions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Transaction Type Selection
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Expense'),
                    leading: Radio<String>(
                      value: 'expense',
                      groupValue: _selectedType,
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Income'),
                    leading: Radio<String>(
                      value: 'income',
                      groupValue: _selectedType,
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Amount Input
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            
            // Description Input
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            
            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            
            // Save Button
            ElevatedButton(
              onPressed: _saveTransaction,
              child: const Text('Save Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTransaction() async {
    final amount = double.tryParse(_amountController.text);
    final description = _descriptionController.text.trim();

    if (amount == null || amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }

    if (description.isEmpty) {
      _showError('Please enter a description');
      return;
    }

    try {
      final transaction = Transaction(
        title: description,
        category: _selectedCategory,
        amount: _selectedType == 'expense' ? -amount : amount,
        date: DateTime.now(),
        type: _selectedType,
      );

      await _dbHelper.insertTransaction(transaction.toMap());
      
      // Clear form
      _amountController.clear();
      _descriptionController.clear();
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${_selectedType == 'expense' ? 'Expense' : 'Income'} saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate back after a short delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pop(context);
      });
      
    } catch (e) {
      _showError('Failed to save transaction: $e');
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