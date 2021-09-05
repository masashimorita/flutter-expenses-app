import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction('t1', 'New Shoes', 69.9, DateTime.now()),
    Transaction('t1', 'Weekly Groceries', 20.2, DateTime.now()),
  ];

  void _addNewTransaction (String txTitle, double txAmount) {
    setState(() {
      final newTx = Transaction(
          DateTime.now().toString(),
          txTitle,
          txAmount,
          DateTime.now()
      );
      this._userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NewTransaction(_addNewTransaction),
      TransactionList(_userTransactions),
    ],);
  }
}
