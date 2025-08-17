import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(transaction.name),
        subtitle: Text(transaction.status),
        trailing: Text("\$${transaction.amount.toStringAsFixed(2)}"),
      ),
    );
  }
}
