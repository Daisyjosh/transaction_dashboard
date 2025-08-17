import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> columns = ['Pending', 'Completed', 'Flagged'];

  @override
  void initState() {
    super.initState();
    final transactionProvider =
    Provider.of<TransactionProvider>(context, listen: false);
    transactionProvider.loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Dashboard"),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Row(
        children: columns.map((status) {
          final items = transactionProvider.transactions
              .where((t) => t.status == status)
              .toList();

          return Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey[300],
                  child: Text(
                    status,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Expanded(
                  child: DragTarget<TransactionModel>(
                    onAccept: (transaction) {
                      transactionProvider.updateStatus(transaction, status);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return ListView(
                        padding: const EdgeInsets.all(8),
                        children: items.map((t) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Draggable<TransactionModel>(
                              data: t,
                              feedback: Material(
                                elevation: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.blueAccent,
                                  child: Text(
                                    "${t.name} - \$${t.amount.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: Text(t.name),
                                  subtitle: Text("\$${t.amount}"),
                                ),
                              ),
                              child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(t.name),
                                  subtitle: Text(
                                      "\$${t.amount.toStringAsFixed(2)} | ${t.date}"),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          transactionProvider.addTransaction(
            TransactionModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: "Sample Transaction",
              amount: 50.0,
              date: DateTime.now().toIso8601String(),
              status: 'Pending',
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
