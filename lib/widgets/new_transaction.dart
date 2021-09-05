import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function onPressedButton;

  NewTransaction(this.onPressedButton);

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
              child: Text('Add Transaction'),
              onPressed: () {
                this.onPressedButton(
                  this.titleController.text,
                  double.parse(this.amountController.text),
                );
                this.titleController.clear();
                this.amountController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
