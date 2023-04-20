import 'package:flutter/material.dart';

class chartBar extends StatelessWidget {
  final String title;
  final double amount;
  final double pcoftotal;
  chartBar(
      {required this.title, required this.amount, required this.pcoftotal});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              "\$${amount.toStringAsFixed(0)}",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 70,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 2,
                ),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: pcoftotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "$title",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
