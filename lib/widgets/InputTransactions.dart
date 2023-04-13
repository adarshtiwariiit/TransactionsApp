import 'package:flutter/material.dart';

class InputTransactions extends StatefulWidget {
  final Function transactionHandler;
  InputTransactions(
    this.transactionHandler,
  );

  @override
  State<InputTransactions> createState() => _InputTransactionsState();
}

class _InputTransactionsState extends State<InputTransactions> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void addTransaction() {
      if (hasNumericValue(amountController.text) &&
          isValidTitle(titleController.text)) {
        widget.transactionHandler(titleController.text, amountController.text);
        Navigator.of(context).pop();
      }
    }

    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            maxLength: 7,
            controller: amountController,
            onSubmitted: (_) => addTransaction(),
            decoration: InputDecoration(
              labelText: "Amount",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
          ),
          TextField(
            controller: titleController,
            onSubmitted: (_) => addTransaction(),
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: addTransaction,
            child: Text(
              "Add Transaction",
              style: TextStyle(
                  color: Colors.lightGreen, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

bool hasNumericValue(String str) {
  try {
    double.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}

bool isValidTitle(String str) {
  // Check if the string is empty
  if (str.isEmpty) {
    return false;
  }

  // Check if the string contains only letters, numbers, and spaces
  RegExp regex = RegExp(r'^[a-zA-Z0-9 ]+$');
  return regex.hasMatch(str);
}
