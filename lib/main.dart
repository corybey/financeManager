// Main Controller for Finance App
// Initializes the app and sets up routes

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/log_transactions.dart';
import 'screens/log_income.dart';
import 'screens/log_savings.dart';
import 'screens/all_transactions.dart';

void main() {
  runApp(FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});
  //create home screen and routes to other screens
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
      routes: {
        '/log_transactions': (context) => LogTransactionsScreen(),
        '/log_income': (context) => LogIncomeScreen(),
        '/log_savings': (context) => LogSavingsScreen(),
        '/all_transactions': (context) => AllTransactionsScreen(),
      },
    );
  }
}
