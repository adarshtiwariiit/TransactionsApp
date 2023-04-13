import 'package:flutter/material.dart';
import './widgets/Transactions.dart';
import './widgets/InputTransactions.dart';
import './classes/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyAppState(),
    );
  }
}

class MyAppState extends StatefulWidget {
  @override
  State<MyAppState> createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> {
  final List<Transaction> transactionsList = [
    Transaction(1.00, "Samosa", DateTime.now()),
    Transaction(20.00, "Dosa", DateTime.now()),
    Transaction(30.00, "Icecream", DateTime.now()),
  ];

  void addTransaction(String title, String amount) {
    setState(() {
      if (title.length > 15) {
        title = title.substring(0, 14) + "..";
      }
      transactionsList
          .add(Transaction(double.parse(amount), title, DateTime.now()));
    });
  }

  void buildInputTransactions(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return InputTransactions(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        actions: [
          IconButton(
              onPressed: () => buildInputTransactions(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 1,
            bottom: 1,
          ),
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.amber,
                child: Text("Chart"),
              ),
            ),
            Transactions(transactionsList),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildInputTransactions(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
