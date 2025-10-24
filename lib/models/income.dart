class Income {
  final int? id;
  final double amount;
  final String description;
  final DateTime date;

  Income({
    this.id,
    required this.amount,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description, // ✅ This matches the database column name
      'date': date.toIso8601String(),
    };
  }

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      amount: map['amount'],
      description: map['description'] ?? '', // ✅ Handle null description
      date: DateTime.parse(map['date']),
    );
  }
}