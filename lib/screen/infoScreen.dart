import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../helper/launchURL.dart';
//import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
      ),
      //TODO: Make SafeArea Scrollable
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: new RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'Quick Guide:\n\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //TODO: Change Font Colors
                        new TextSpan(
                          text:
                              '\n1. RED is Active, BLACK is Death, GREEN is Recovered\n\n',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        myText(
                            '2. Data will be updated every hour. However, data is not 100% guarantee.\n\n'),
                        myText(
                            '3. I will try to give the most updated information\n\n'),
                        myText(
                            '4. Please turn on location service to get county data\n\n'),
                        myText(
                            '5. If the location is not found, the default Region is mainland USA.\n\n'),
                        myText(
                            '6. This data does not contain Diamond Princess.\n\n'),
                        myText('7. This data only contain mainland USA.\n\n'),
                        myText(
                            '8. If you find any bugs or issues or false data, please report to '),
                        new TextSpan(
                          text: 'chlee1252@gmail.com',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: new TapGestureRecognizer() ..onTap = () {
                            launchURL('mailto:chlee1252@gmail.com?subject=Reports');
                          }
                        ),
                        new TextSpan(
                          text: '\n\n\nSources\n\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        new TextSpan(
                          text: '- USA Facts\n',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launchURL(
                                  'https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/');
                            },
                        ),
                        myText('- Johns Hopkins CSSE\n'),
                        myText('- WHO\n'),
                        myText('- CDC USA\n'),
                        myText('- CSBS\n'),
                        myText('- State and Local Agencies\n'),
//                        myText('\n\n\n\nStay Inside, we shall overcome.\n'),
                        myText('\n\n\n\n2020 \u00a9 Changhwan Lee'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TextSpan myText(String str) {
  return new TextSpan(
    text: str,
    style: TextStyle(
      color: Colors.black,
      fontSize: 15.0,
    ),
  );
}
