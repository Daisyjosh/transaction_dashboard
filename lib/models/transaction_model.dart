class TransactionModel {
  final String id;
  final String name;
  final double amount;
  final String date;
  final String status;

  TransactionModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      name: json['name'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date,
      'status': status,
    };
  }
}
