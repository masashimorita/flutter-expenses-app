import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  Widget _buildNoTransactionView() {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Text(
            'No transaction added yet!',
            style: Theme.of(ctx).textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    });
  }

  Widget _buildTransactionItems() {
    return ListView.builder(
      itemCount: this.transactions.length,
      itemBuilder: (ctx, index) {
        return TransactionItem(
          transaction: this.transactions[index],
          onDeletePressed: this.deleteTransaction,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.transactions.isEmpty
        ? _buildNoTransactionView()
        : _buildTransactionItems();
  }
}
