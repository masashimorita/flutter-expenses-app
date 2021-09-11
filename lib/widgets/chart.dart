import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final double totalAmount = this.recentTransactions.fold(0.0, (sum, tx) {
        final DateTime d = tx.date;
        if (weekDay.year == d.year &&
            weekDay.month == d.month &&
            weekDay.day == d.day) {
          return sum + tx.amount;
        } else {
          return sum;
        }
      });
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount,
      };
    }).toList();
  }

  double get totalSpending {
    return this.groupedTransactionValues.fold(0.0, (sum, data) {
      return sum + (data['amount'] as double);
    });
  }

  List<Widget> _buildBars() {
    return this.groupedTransactionValues.map<Widget>((data) {
      final double percentage = this.totalSpending == 0.0
          ? 0.0
          : ((data['amount'] as double) / this.totalSpending);
      return Flexible(
        fit: FlexFit.tight,
        child: ChartBar(
          (data['day'] as String),
          (data['amount'] as double),
          percentage,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildBars(),
        ),
      ),
    );
  }
}
