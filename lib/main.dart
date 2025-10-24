import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/log_transactions.dart';
import 'screens/log_income.dart';
import 'screens/log_savings.dart';
import 'screens/all_transactions.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});
  
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
        '/log_transactions': (context) => const LogTransactionsScreen(),
        '/log_income': (context) => const LogIncomeScreen(),
        '/log_savings': (context) => const LogSavingsScreen(),
        '/all_transactions': (context) => const AllTransactionsScreen(),
      },
    );
  }
}