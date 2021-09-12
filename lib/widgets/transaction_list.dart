import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  Widget _buildNoTransactionView () {
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
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    '\$${this.transactions[index].amount.toStringAsFixed(2)}',
                  ),
                ),
              ),
            ),
            title: Text(
              this.transactions[index].title,
              style: Theme.of(ctx).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(this.transactions[index].date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(ctx).errorColor,
              onPressed: () {
                this.deleteTransaction(this.transactions[index].id);
              },
            ),
          ),
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
