//sample data for use cases and tests
// sql will be implemented later

final List<Map<String, dynamic>> sampleTransactions = [
  {
    'title': 'Paycheck',
    'category': 'Income',
    'amount': 1500.00,
    'date': '2025-01-15',
  },
  {
    'title': 'Groceries',
    'category': 'Food',
    'amount': -76.20,
    'date': '2025-01-16',
  },
  {
    'title': 'Gas',
    'category': 'Transport',
    'amount': -35.00,
    'date': '2025-01-17',
  },
];

/// Sample balance value (income - expenses).
double sampleTotalBalance = 1500 - 76.20 - 35;

/// Sample list of categories to display.
final List<Map<String, String>> sampleCategories = [
  {'name': 'Food', 'icon': '🍽️'},
  {'name': 'Transport', 'icon': '🚗'},
  {'name': 'Income', 'icon': '💪'},
  {'name': 'Entertainment', 'icon': '🎮'},
  {'name': 'Savings', 'icon': '💰'},
];
