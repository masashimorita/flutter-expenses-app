import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: this.transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : _buildTransactionItems(),
    );
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
}
