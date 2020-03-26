import 'package:flutter/material.dart';

import './statusCard.dart';
import './chartCard.dart';

class statusSection extends StatelessWidget {
  statusSection({this.userCounty, this.countyService, this.stateData});

  final double Barheight = 200.0;

  final userCounty;
  final countyService;
  final stateData;
  var height;
  @override
  Widget build(BuildContext context) {
//    final double statusBarHeight = MediaQuery.of(context).padding.top;
//    var height = context.size.height;
    return Container(
      padding: new EdgeInsets.only(top: 60.0),
      child: SafeArea(
        child: countyService != null
            ? Container(
              child: Column(
                  children: <Widget>[
                    // Location Area
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10.0,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.body1,
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0,
                                    ),
                                    child: Icon(
                                      Icons.add_location,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: userCounty.county == null
                                      ? "Default Region: United States"
                                      : "${userCounty.county} County, ${userCounty.code}, USA",
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SubTitle Area
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            userCounty.county == null
                                ? 'USA (Mainland)'
                                : "${userCounty.county} County, ${userCounty.code}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    // Update Date Area
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Updated: ${countyService.date == null ? stateData[0].date : countyService.date}",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.0,
                      ),
                      child: countyService == null
                          ? Text('Your County does not have data on dataset yet.')
                          : GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              physics: ScrollPhysics(),
                              padding: EdgeInsets.all(3.0),
                              shrinkWrap: true,
                              children: <Widget>[
                                makeDashBoardItem(
                                  titleText("ACTIVE", Colors.grey),
                                  titleText(
                                      userCounty.county == null
                                          ? (stateData == null
                                              ? 'Loading...'
                                              : stateData[0].active.toString())
                                          : countyService.affected == null
                                              ? "0"
                                              : countyService.affected.toString(),
                                      Colors.red),
                                ),
                                makeDashBoardItem(
                                  titleText("DEATHS", Colors.grey),
                                  titleText(
                                      userCounty.county == null
                                          ? (stateData == null
                                              ? 'Loading...'
                                              : stateData[0].death.toString())
                                          : countyService.deaths == null
                                              ? '0'
                                              : countyService.deaths.toString(),
                                      Colors.black),
                                ),
//                        makeDashBoardItem(
//                          titleText("RECOVERED", Colors.grey),
//                          titleText("1234", Colors.green),
//                        ),
                              ],
                            ),
                    ),
//            chartCard(),
                  ],
                ),
            )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
      ),
    );
  }
}
