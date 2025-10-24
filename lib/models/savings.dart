class Savings {
  final int? id;
  final double amount;
  final String? goalName;
  final DateTime date;

  Savings({
    this.id,
    required this.amount,
    this.goalName,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'goal_name': goalName,
      'date': date.toIso8601String(),
    };
  }

  factory Savings.fromMap(Map<String, dynamic> map) {
    return Savings(
      id: map['id'],
      amount: map['amount'],
      goalName: map['goal_name'],
      date: DateTime.parse(map['date']),
    );
  }
}