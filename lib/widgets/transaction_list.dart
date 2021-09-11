import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: this.transactions.isEmpty ? Column(
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
      ) : _buildTransactionItems(),
    );
  }

  Widget _buildTransactionItems() {
    return ListView.builder(
      itemCount: this.transactions.length,
      itemBuilder: (ctx, index) {
        return Card(
          child: Row(
            children: [
              Container(
                child: Text(
                  '\$${this.transactions[index].amount.toStringAsFixed(2)}',
                  style: Theme.of(ctx).textTheme.headline6,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(ctx).primaryColor,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Column(
                children: [
                  Text(
                    this.transactions[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(this.transactions[index].date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),
        );
      },
    );
  }
}
