import 'package:flutter/material.dart';

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No transactions yet!",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
