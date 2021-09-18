import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function onDeletePressed;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onDeletePressed
  }) : super(key: key);

  Widget _buildDeleteButton(BuildContext ctx) {
    return (MediaQuery.of(ctx).size.width > 500)
        ? TextButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Theme.of(ctx).errorColor,
              ),
            ),
            onPressed: () {
              this.onDeletePressed(this.transaction.id);
            },
          )
        : IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(ctx).errorColor,
            onPressed: () {
              this.onDeletePressed(this.transaction.id);
            },
          );
  }

  @override
  Widget build(BuildContext context) {
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
                '\$${this.transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          this.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(this.transaction.date),
        ),
        trailing: _buildDeleteButton(context),
      ),
    );
  }
}
