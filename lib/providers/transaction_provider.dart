import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final String response =
    await rootBundle.loadString('assets/transactions.json');
    final data = await json.decode(response) as List;
    _transactions =
        data.map((json) => TransactionModel.fromJson(json)).toList();
    notifyListeners();
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
