import 'package:flutter/material.dart';

Card makeDashBoardItem(Text title, Text number, Text newStats) {
  return Card(
    elevation: 1.0,
    margin: new EdgeInsets.all(8.0),
    child: Container(
      height: 100.0,
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
      child: new InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: title,
            ),
            SizedBox(
              height: 5.0,
            ),
            new Center(
              child: number,
            ),
            newStats.data != '' ? Center(
              child: newStats,
            ) : Center(),
          ],
        ),
      ),
    ),
  );
}

Text titleText(String title, Color color) {
  return Text(
    title,
    style: new TextStyle(
      fontSize: 15.0,
      color: color,
      fontWeight: FontWeight.bold,
    ),
  );
}


