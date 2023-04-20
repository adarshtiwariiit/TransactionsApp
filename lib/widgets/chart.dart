import 'package:flutter/material.dart';
import '../classes/Transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  double _totalAmount = 0;

  Chart(this._recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      DateTime temp = DateTime.now().subtract(Duration(days: index));
      double amount = 0;
      for (int i = 0; i < _recentTransactions.length; i++)
        if (_recentTransactions[i].dateTime.day == temp.day &&
            _recentTransactions[i].dateTime.year == temp.year &&
            _recentTransactions[i].dateTime.month == temp.month) {
          amount += _recentTransactions[i].amount;
          _totalAmount += _recentTransactions[i].amount;
        }
      return {
        'day': DateFormat.E().format(temp).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8.0, 10, 8.0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: chartBar(
                  title: data['day'] as String,
                  amount: (double.parse(data['amount'].toString())),
                  pcoftotal: (_totalAmount == 0
                      ? 0
                      : double.parse(data['amount'].toString()) / _totalAmount),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
