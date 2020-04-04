import 'package:CoronaNotifier/helper/timeSeries.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../service/timeData.dart';
import '../widget/chartCard.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({this.title});
  final String title;
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  var title;
  TimeData timeData;
//  List<TimeSeries> timeAffectedData;
//  List<TimeSeries> timeDeathData;

  @override
  void initState() {
    super.initState();
    this.title = widget.title;
    _getData().then((d) {
      setState(() {
        this.timeData = d;
      });
    });
  }

  Future _getData() async {
    var data;
    try {
      data = new TimeData();
      await data.getTimeData();
    } catch (e) {
      return null;
    }

    return data;
  }

  Widget chartWidget(
      List<TimeSeries> affectedData, List<TimeSeries> deathData) {
    var affectedSeries = [
      new charts.Series<TimeSeries, DateTime>(
        id: 'Affected',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeries time, _) => time.date,
        measureFn: (TimeSeries time, _) => time.data,
        data: affectedData,
      )
    ];

    var deathSeries = [
      new charts.Series<TimeSeries, DateTime>(
        id: 'Death',
        colorFn: (_, __) => charts.Color.fromHex(code: '#000000'),
        domainFn: (TimeSeries time, _) => time.date,
        measureFn: (TimeSeries time, _) => time.data,
        data: deathData,
      )
    ];

    var chart = new charts.TimeSeriesChart(
      affectedSeries,
      animate: true,
      behaviors: [new charts.ChartTitle('Affected Rate')],
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.black,
          ),
          labelStyle: new charts.TextStyleSpec(
            fontSize: 11,
          ),
          lineStyle: charts.LineStyleSpec(
              thickness: 1, color: charts.MaterialPalette.gray.shadeDefault),
        ),
      ),
    );
    var deathChart = new charts.TimeSeriesChart(
      deathSeries,
      animate: true,
      behaviors: [new charts.ChartTitle('Deaths Rate')],
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.black,
          ),
          lineStyle: charts.LineStyleSpec(
              thickness: 1, color: charts.MaterialPalette.gray.shadeDefault),
        ),
      ),
    );

    return SafeArea(
      child: new Column(
        children: <Widget>[
          Expanded(
            child: new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new SizedBox(
//              height: 300.0,
                child: chartCard(chart),
              ),
            ),
          ),
          Expanded(
            child: new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new SizedBox(
//              height: 300.0,
                child: chartCard(deathChart),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: this.timeData == null
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black)),
            )
          : chartWidget(this.timeData.affectedData, this.timeData.deathData),
    );
  }
}
