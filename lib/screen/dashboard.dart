import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:CoronaNotifier/service/userCounty.dart';
import 'package:CoronaNotifier/service/countyService.dart';
import 'package:CoronaNotifier/service/stateData.dart';
import 'package:CoronaNotifier/widget/status.dart';
import 'package:CoronaNotifier/screen/screens.dart';

import '../service/countyService.dart';
import '../service/stateData.dart';

class DashBoard extends StatefulWidget {
  DashBoard({this.userCounty, this.countyURL});

  final userCounty;
  final countyURL;

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
    _getLastdata().then((data) {
      setState(() {
        this.data = data;
      });
    });
    _getCountyData().then((data) {
      setState(() {
        this.countyService = data;
      });
    });
  }

  Future<CountyService> _getCountyData() async {
    CountyService countyService;
    try {
      countyService = CountyService(widget.countyURL);
      await countyService.getCountyData();
    } catch (e) {
      countyService = null;
    }

    return countyService;
  }

  Future<List> _getLastdata() async {
    StateData stateD;
    try {
      stateD = StateData();
      await stateD.getStateData();
    } catch (e) {
      stateD = null;
    }
    return stateD.stateData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: new Text(
            'CoronaNotifier',
            style: new TextStyle(
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return InfoScreen();
              }));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoadingScreen();
              }));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: this.data == null
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation(Colors.black),
                ),
              )
            : Scrollbar(
                child: ListView.separated(
                  itemCount: this.data.length + 2,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0.0,
                      color: Colors.white,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return StatusSection(
                        userCounty: userCounty,
                        countyService: countyService,
                        stateData: data,
                      );
                    } else if (index == 1) {
                      return Divider();
                    } else {
                      final current = data[index - 2];
                      return Container(
                        height: 120.0,
                        child: Card(
                          color: Color.fromRGBO(220, 220, 220, 1.0),
                          child: Center(
                            child: ListTile(
                              dense: true,
                              title: AutoSizeText(
                                current.state,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                minFontSize: 5.0,
                              ),
                              subtitle: AutoSizeText.rich(
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: 'Today: '),
                                    TextSpan(
                                      text: current.newActive > 0
                                          ? '↑ ${current.newActive.toString()}   '
                                          : '- 0   ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    TextSpan(
                                      text: current.newDeath > 0
                                          ? '↑ ${current.newDeath.toString()}'
                                          : '- 0',
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                minFontSize: 5.0,
                              ),
                              trailing: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.5,
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
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ChartScreen(
                                            title: current.state);
                                      },
                                    ),
                                  );
//                                    return null;
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailScreen(
                                            title: current.state);
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
      ),
    );
  }
}
