import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  // Load transactions from shared_preferences or default JSON
  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('transactions');
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      _transactions =
          jsonList.map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      _transactions = []; // empty initially
    }
    notifyListeners();
  }

  Future<void> saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_transactions.map((e) => e.toJson()).toList());
    await prefs.setString('transactions', data);
  }

  void addTransaction(TransactionModel t) {
    _transactions.add(t);
    saveTransactions();
    notifyListeners();
  }

  void updateStatus(TransactionModel t, String newStatus) {
    final index = _transactions.indexWhere((element) => element.id == t.id);
    if (index != -1) {
      _transactions[index].status = newStatus;
      saveTransactions();
      notifyListeners();
    }
  }
}
