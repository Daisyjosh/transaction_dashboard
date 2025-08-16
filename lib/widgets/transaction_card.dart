import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (transaction.status) {
      case "completed":
        statusColor = Colors.green;
        break;
      case "pending":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Text("\$${transaction.amount.toInt()}",
              style: TextStyle(color: statusColor)),
        ),
        title: Text(transaction.name),
        subtitle: Text(transaction.date),
        trailing: Text(
          transaction.status,
          style: TextStyle(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
