import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashboard.dart';

import '../service/location.dart';
import '../service/userCounty.dart';
import '../service/countyService.dart';
import '../service/stateData.dart';

import '../geoAPI/myAPI.dart';
import '../geoAPI/geoAPI.dart';

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

    var newURI = url + "lat=${location.lat}&lon=${location.long}";

    var userCounty = UserCounty(newURI);
    await userCounty.getCounty();

    var countyName = userCounty.county;
    var stateName = userCounty.state;
    var countyURL = county_url + "/$stateName/$countyName";

//    var countyService = CountyService(countyURL);
//    await countyService.getCountyData();



    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DashBoard(
            userCounty: userCounty,
            countyURL: countyURL,
//            countyService: countyService,
//            stateData: stateData.stateData,
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
