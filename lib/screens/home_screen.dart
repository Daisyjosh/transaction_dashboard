import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/transaction_card.dart';
import '../widgets/empty_transactions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Dashboard"),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: transactionProvider.transactions.isEmpty
          ? const EmptyTransactions()
          : ListView.builder(
        itemCount: transactionProvider.transactions.length,
        itemBuilder: (context, index) {
          final tx = transactionProvider.transactions[index];
          return TransactionCard(transaction: tx);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          transactionProvider.addTransaction(
            transactionProvider.transactions.isEmpty
                ? transactionProvider.transactions.first
                : transactionProvider.transactions.last,
          );
        },
      ),
    );
  }
}
