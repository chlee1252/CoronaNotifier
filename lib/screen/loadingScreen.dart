import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:CoronaNotifier/API/geoAPI.dart';
import 'package:CoronaNotifier/API/myAPI.dart';
import 'package:CoronaNotifier/screen/dashboard.dart';
import 'package:CoronaNotifier/service/location.dart';
import 'package:CoronaNotifier/service/userCounty.dart';

import '../service/userCounty.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    Location location = Location();
    await location.getLocation();

    String newURI = url + "lat=${location.lat}&lon=${location.long}";

    UserCounty userCounty = UserCounty(newURI);
    await userCounty.getCounty();

    String countyName = userCounty.county;
    String stateName = userCounty.state;
    String countyURL = county_url + "/$stateName/$countyName";


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DashBoard(
            userCounty: userCounty,
            countyURL: countyURL,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "CoronaNotifier",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            SpinKitDoubleBounce(
              color: Colors.black,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
