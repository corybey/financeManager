// BASIC REPORTS AND CATEGORY BREAKDOWN

import 'package:flutter/material.dart';
import '../widgets/balance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),

      // Drawer menu (Options tab)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Options',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // Each ListTile navigates to a different screen
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Log Income'),
              onTap: () => Navigator.pushNamed(context, '/log_income'),
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle),
              title: const Text('Log Transactions'),
              onTap: () => Navigator.pushNamed(context, '/log_transactions'),
            ),
            ListTile(
              leading: const Icon(Icons.savings),
              title: const Text('Log Savings'),
              onTap: () => Navigator.pushNamed(context, '/log_savings'),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('All Transactions'),
              onTap: () => Navigator.pushNamed(context, '/all_transactions'),
            ),
          ],
        ),
      ),

      //Main
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            // Display total balance card
            BalanceWidget(),
            SizedBox(height: 20),

            // Welcome message
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
