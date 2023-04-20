import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classes/Transaction.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> _transactionsList;
  final Function _deleteTransactions;
  Transactions(this._transactionsList, this._deleteTransactions);
  @override
  Widget build(BuildContext context) {
    return _transactionsList.isEmpty
        ? Column(
            children: [
              Text(
                "No transactions to show!",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 300,
                child: Image.asset("assets/images/waiting.png"),
              ),
            ],
          )
        : Container(
            height: 500,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: FittedBox(
                          child: Text(
                            "\$${_transactionsList[index].amount.toStringAsFixed(2)}",
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactionsList[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(_transactionsList[index].dateTime)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTransactions(_transactionsList[index].id);
                      },
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
                // child: Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.all(10),
                //   padding: const EdgeInsets.all(10),
                //   child: Row(
                //     children: [
                //       Container(
                //         padding: const EdgeInsets.all(5),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Theme.of(context).accentColor,
                //             width: 1,
                //           ),
                //         ),
                //         child: Text(
                //           '\$  ${_transactionsList[index].amount.toStringAsFixed(2).padLeft(7, '0')}',
                //           style: TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //             color: Theme.of(context).accentColor,
                //           ),
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.fromLTRB(20, 1, 2, 1),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               _transactionsList[index].title,
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .titleLarge
                //                   ?.copyWith(
                //                     color: Theme.of(context).primaryColor,
                //                   ),
                //             ),
                //             Text(
                //               DateFormat.yMMMMd('en_US')
                //                   .add_jm()
                //                   .format(_transactionsList[index].dateTime),
                //               style: TextStyle(
                //                 fontSize: 13,
                //                 fontWeight: FontWeight.bold,
                //                 color: Theme.of(context).primaryColor,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              },
              itemCount: _transactionsList.length,
            ),
          );
  }
}
