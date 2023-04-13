import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classes/Transaction.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> _transactionsList;
  Transactions(this._transactionsList);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._transactionsList.map((Tx) {
          return Card(
            elevation: 2,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '\$  ${Tx.amount.toStringAsFixed(2).padLeft(7, '0')}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 1, 2, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Tx.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.lightBlue),
                        ),
                        Text(
                          DateFormat.yMMMMd('en_US')
                              .add_jm()
                              .format(Tx.dateTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
