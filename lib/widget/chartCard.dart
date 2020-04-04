import 'package:flutter/material.dart';

Card chartCard(Widget chart) {
  return Card(
    elevation: 1.0,
    margin: new EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(220, 220, 220, 1.0),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          bottom: Radius.circular(5.0),
        ),
        boxShadow: [
          new BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: chart
    ),
  );
}

