// SAVINGS GOALS

import 'package:flutter/material.dart';

class LogSavingsScreen extends StatelessWidget {
  const LogSavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Log Savings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Amount Saved'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Goal Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add to Savings'),
            ),
          ],
        ),
      ),
    );
  }
}
