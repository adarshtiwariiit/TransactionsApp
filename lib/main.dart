import 'package:flutter/material.dart';
import 'package:transactions_app/widgets/chart.dart';
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
      title: 'Transactions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orange,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
              .titleLarge,
        ),
      ),
      home: MyAppState(),
    );
  }
}

class MyAppState extends StatefulWidget {
  @override
  State<MyAppState> createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> {
  final List<Transaction> _transactionsList = [
    // Transaction(1.00, "Samosa", DateTime.now()),
    // Transaction(20.00, "Dosa", DateTime.now()),
    // Transaction(30.00, "Icecream", DateTime.now()),
    // Transaction(1.00, "Samosa", DateTime.now()),
    // Transaction(20.00, "Dosa", DateTime.now()),
    // Transaction(30.00, "Icecream", DateTime.now()),
    // Transaction(1.00, "Samosa", DateTime.now()),
    // Transaction(20.00, "Dosa", DateTime.now()),
    // Transaction(30.00, "Icecream", DateTime.now()),
  ];
  List<Transaction> _recentTransactions() {
    return _transactionsList
        .where((element) => element.dateTime
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void addTransaction(String title, String amount, DateTime chosenDate) {
    setState(() {
      if (title.length > 15) {
        title = title.substring(0, 14) + "..";
      }
      _transactionsList.add(Transaction(
          chosenDate.toString() + DateTime.now().toString(),
          double.parse(amount),
          title,
          chosenDate));
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionsList.removeWhere((tx) => tx.id == id);
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
        title: Text(
          'Transactions',
        ),
        actions: [
          IconButton(
              onPressed: () => buildInputTransactions(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
          top: 1,
          bottom: 1,
        ),
        child: Column(
          children: [
            Chart(_recentTransactions()),
            Transactions(_transactionsList, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildInputTransactions(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
