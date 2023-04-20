import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTransactions extends StatefulWidget {
  final Function transactionHandler;
  InputTransactions(
    this.transactionHandler,
  );

  @override
  State<InputTransactions> createState() => _InputTransactionsState();
}

class _InputTransactionsState extends State<InputTransactions> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  void addTransaction() {
    if (hasNumericValue(_amountController.text) &&
        isValidTitle(_titleController.text) &&
        _selectedDate != null) {
      widget.transactionHandler(
          _titleController.text, _amountController.text, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _amountController,
            onSubmitted: (_) => addTransaction(),
            decoration: InputDecoration(
              labelText: "Amount",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).accentColor,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
          TextField(
            controller: _titleController,
            onSubmitted: (_) => addTransaction(),
            decoration: InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).accentColor,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            child: Row(
              children: [
                if (_selectedDate == null)
                  Expanded(child: Text("no date choosen"))
                else
                  Expanded(
                    child: Text(
                        "Date: ${DateFormat.yMd().format(_selectedDate!)}"),
                  ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    "choose date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: addTransaction,
            child: Text(
              "Add Transaction",
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.bold,
              ),
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
