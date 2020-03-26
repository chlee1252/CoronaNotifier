import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

Card chartCard() {
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
      child:
        Text("")
    ),
  );
}

// Card makeDashBoardItem(Text title, Text number) {
//  return Card(
//    elevation: 1.0,
//    margin: new EdgeInsets.all(8.0),
//    child: Container(
//      decoration: BoxDecoration(
//        color: Color.fromRGBO(220, 220, 220, 1.0),
//        borderRadius: BorderRadius.vertical(
//          top: Radius.circular(5.0),
//          bottom: Radius.circular(5.0),
//        ),
//        boxShadow: [
//          new BoxShadow(
//            color: Colors.grey,
//            blurRadius: 10.0,
//          ),
//        ],
//      ),
//      child: new InkWell(
//        onTap: () {},
//        child: Column(
////          crossAxisAlignment: CrossAxisAlignment.stretch,
//          mainAxisAlignment: MainAxisAlignment.center,
////          mainAxisSize: MainAxisSize.min,
////          verticalDirection: VerticalDirection.down,
//          children: <Widget>[
//            Center(
//              child: title,
//            ),
//            SizedBox(
//              height: 5.0,
//            ),
//            new Center(
//              child: number,
//            ),
//          ],
//        ),
//      ),
//    ),
//  );
//}
