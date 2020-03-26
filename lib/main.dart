import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screen/loadingScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
        title: 'CoronaNotifier',
        theme:
            new ThemeData(primaryColor: Colors.white, fontFamily: 'Montserrat'),
        home: LoadingScreen());
  }
}
