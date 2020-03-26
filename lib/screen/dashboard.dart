import 'package:flutter/material.dart';

import '../service/userCounty.dart';
import '../service/countyService.dart';
import '../service/stateData.dart';


import '../widget/status.dart';

import 'loadingScreen.dart';
import 'infoScreen.dart';

class DashBoard extends StatefulWidget {
  DashBoard({this.userCounty, this.countyURL});

  final userCounty;
  final countyURL;
//  final countyService;
//  final stateData;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashBoard> {
  List data;
  UserCounty userCounty;
  CountyService countyService;

  @override
  void initState() {
    super.initState();
    userCounty = widget.userCounty;
//    countyService = widget.countyService;
    _getCountyData().then((data) {
      setState(() {
        this.countyService = data;
      });
    });
    _getLastdata().then((data) {
      setState(() {
        this.data = data;
      });
    });
  }

  Future<CountyService> _getCountyData() async {
    var countyService = CountyService(widget.countyURL);
    await countyService.getCountyData();
    return countyService;
  }

  Future _getLastdata() async {
      var stateD = StateData();
      await stateD.getStateData();
      return stateD.stateData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'CoronaNotifier',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.info,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InfoScreen();
                          },
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoadingScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
                pinned: true,
//              expandedHeight: MediaQuery.of(context).size.height,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: statusSection(
                    userCounty: userCounty,
                    countyService: countyService,
                    stateData: data,
                  ),
                ),
              ),
            ];
          },
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: new Container(
              child: this.data == null
                  ? Center(
                      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),),
                    )
                  : Scrollbar(
                      child: ListView.separated(
                        itemCount: this.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final current = data[index];
                          return Container(
                            height: 100.0,
                            child: Card(
                              color: Color.fromRGBO(220, 220, 220, 1.0),
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    current.state,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: current.active.toString(),
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        TextSpan(text: ' | '),
                                        TextSpan(text: current.death.toString()),
                                        TextSpan(text: ' | '),
                                        TextSpan(
                                          text: current.recovered.toString(),
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          height: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
//
//return Scaffold(
//backgroundColor: Colors.white,
//body: SafeArea(
//child: NestedScrollView(
//headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//return <Widget>[
//SliverAppBar(
//title: FittedBox(
//fit: BoxFit.fitWidth,
//child: Text(
//'CoronaNotifier',
//style: TextStyle(
//color: Colors.black,
//fontSize: 30.0,
//),
//),
//),
//actions: <Widget>[
//IconButton(
//icon: const Icon(
//Icons.info,
//color: Colors.black,
//),
//onPressed: () {
//Navigator.push(
//context,
//MaterialPageRoute(
//builder: (context) {
//return InfoScreen();
//},
//),
//);
//},
//),
//IconButton(
//icon: const Icon(
//Icons.refresh,
//color: Colors.black,
//),
//onPressed: () {
//Navigator.pushReplacement(
//context,
//MaterialPageRoute(
//builder: (context) {
//return LoadingScreen();
//},
//),
//);
//},
//),
//],
//pinned: true,
////              expandedHeight: MediaQuery.of(context).size.height,
//expandedHeight: 300.0,
//flexibleSpace: FlexibleSpaceBar(
//collapseMode: CollapseMode.pin,
//background: statusSection(
//userCounty: userCounty,
//countyService: countyService,
//stateData: data,
//),
//),
//),
//];
//},
//body: MediaQuery.removePadding(
//context: context,
//removeTop: true,
//child: new Container(
//child: this.data == null
//? Center(
//child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),),
//)
//: Scrollbar(
//child: ListView.separated(
//itemCount: this.data.length,
//itemBuilder: (BuildContext context, int index) {
//final current = data[index];
//return Container(
//height: 100.0,
//child: Card(
//color: Color.fromRGBO(220, 220, 220, 1.0),
//child: Center(
//child: ListTile(
//title: Text(
//current.state,
//style: TextStyle(
//fontWeight: FontWeight.bold,
//fontSize: 18.0,
//color: Colors.black,
//),
//),
//trailing: RichText(
//text: TextSpan(
//style: TextStyle(
//color: Colors.black,
//fontSize: 20.0,
//fontWeight: FontWeight.bold,
//),
//children: <TextSpan>[
//TextSpan(
//text: current.active.toString(),
//style: TextStyle(
//color: Colors.red,
//),
//),
//TextSpan(text: ' | '),
//TextSpan(text: current.death.toString()),
//TextSpan(text: ' | '),
//TextSpan(
//text: current.recovered.toString(),
//style: TextStyle(
//color: Colors.green,
//),
//),
//],
//),
//),
//),
//),
//),
//);
//},
//separatorBuilder: (BuildContext context, int index) =>
//const Divider(
//height: 0.0,
//color: Colors.white,
//),
//),
//),
//),
//),
//),
//),
//);

//    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//        centerTitle: false,
//        elevation: 0.0,
//        backgroundColor: Colors.white,
//        title: FittedBox(
//          fit: BoxFit.fitWidth,
//          child: new Text(
//            "CoronaNotifier",
//            style: new TextStyle(
//              color: Colors.black,
//              fontSize: 30.0,
//            ),
//          ),
//        ),
//        actions: <Widget>[
//          IconButton(
//            icon: const Icon(
//              Icons.info,
//              color: Colors.black,
//            ),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(
//                builder: (context) {
//                  return InfoScreen();
//                },
//              ));
//            },
//          ),
//          IconButton(
//            icon: const Icon(
//              Icons.refresh,
//              color: Colors.black,
//            ),
//            onPressed: () {
//              Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(
//                  builder: (context) {
//                    return LoadingScreen();
//                  },
//                ),
//              );
//            },
//          ),
//        ],
//      ),
//      body: SafeArea(
//        child: Column(
////        padding: EdgeInsets.symmetric(vertical: 3.0),
//          children: <Widget>[
//            // This is location Area
//            Align(
//              alignment: Alignment.centerLeft,
//              child: Container(
//                padding: EdgeInsets.symmetric(
//                  vertical: 5.0,
//                  horizontal: 10.0,
//                ),
//                child: FittedBox(
//                  fit: BoxFit.fitWidth,
//                  child: RichText(
//                    text: TextSpan(
//                      style: Theme.of(context).textTheme.body1,
//                      children: [
//                        WidgetSpan(
//                          child: Padding(
//                            padding: const EdgeInsets.symmetric(
//                              horizontal: 2.0,
//                            ),
//                            child: Icon(
//                              Icons.add_location,
//                            ),
//                          ),
//                        ),
//                        TextSpan(
//                          text: userCounty.county == null
//                              ? "Default Region: United States"
//                              : "${userCounty.county} County, ${userCounty.code}, USA",
//                          style: new TextStyle(
//                            fontSize: 18.0,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            // SubTitle Area
//            FittedBox(
//              fit: BoxFit.fitWidth,
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Container(
//                  child: Text(
//                    userCounty.county == null
//                        ? 'USA (Mainland)'
//                        : "${userCounty.county} County, ${userCounty.code}",
//                    style:
//                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                  ),
//                ),
//              ),
//            ),
//
//            Align(
//              alignment: Alignment.centerLeft,
//              child: Container(
//                padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                child: Text(
//                  "Updated: ${countyService.date}",
//                ),
//              ),
//            ),
//            // Status Area
//            Container(
//              padding: EdgeInsets.symmetric(
//                horizontal: 2.0,
//              ),
//              child: countyService == null
//                  ? Text('Your County does not have data on dataset yet.')
//                  : GridView.count(
//                      crossAxisCount: 2,
//                      childAspectRatio: 1.5,
//                      padding: EdgeInsets.all(3.0),
//                      shrinkWrap: true,
//                      children: <Widget>[
//                        makeDashBoardItem(
//                          titleText("ACTIVE", Colors.grey),
//                          titleText(
//                              userCounty.county == null
//                                  ? stateData[0].active.toString()
//                                  : countyService.affected == null
//                                      ? "Loading..."
//                                      : countyService.affected.toString(),
//                              Colors.red),
//                        ),
//                        makeDashBoardItem(
//                          titleText("DEATHS", Colors.grey),
//                          titleText(
//                              userCounty.county == null
//                                  ? "Loading..."
//                                  : countyService.deaths == null
//                                      ? '0'
//                                      : countyService.deaths.toString(),
//                              Colors.black),
//                        ),
////                        makeDashBoardItem(
////                          titleText("RECOVERED", Colors.grey),
////                          titleText("1234", Colors.green),
////                        ),
//                      ],
//                    ),
//            ),
//            Divider(),
//            FittedBox(
//              fit: BoxFit.fitWidth,
//              child: Text(
//                "Red is Active, Black is Death, Green is Recovered",
//              ),
//            ),
//            // This is ListView Area
//            new Expanded(
//              child: this.stateData == null
//                  ? Center(
//                      child: Text(
//                        'Loading...',
//                      ),
//                    )
//                  : Scrollbar(
//                      child: ListView.separated(
//                        itemCount: this.stateData.length,
//                        itemBuilder: (BuildContext context, int index) {
//                          final current = stateData[index];
//                          return Container(
//                            height: 120.0,
//                            child: Card(
//                              color: Color.fromRGBO(220, 220, 220, 1.0),
//                              child: Center(
//                                child: ListTile(
//                                  title: Text(
//                                    current.state,
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.bold,
//                                      fontSize: 18.0,
//                                      color: Colors.black,
//                                    ),
//                                  ),
//                                  trailing: RichText(
//                                    text: TextSpan(
//                                      style: TextStyle(
//                                        color: Colors.black,
//                                        fontSize: 20.0,
//                                        fontWeight: FontWeight.bold,
//                                      ),
//                                      children: <TextSpan>[
//                                        TextSpan(
//                                          text: current.active.toString(),
//                                          style: TextStyle(
//                                            color: Colors.red,
//                                          ),
//                                        ),
//                                        TextSpan(text: ' | '),
//                                        TextSpan(
//                                            text: current.death.toString()),
//                                        TextSpan(text: ' | '),
//                                        TextSpan(
//                                          text: current.recovered.toString(),
//                                          style: TextStyle(
//                                            color: Colors.green,
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          );
//                        },
//                        separatorBuilder: (BuildContext context, int index) =>
//                            const Divider(
//                          height: 0.0,
//                          color: Colors.white,
//                        ),
//                      ),
//                    ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
