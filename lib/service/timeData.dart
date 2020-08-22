import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:CoronaNotifier/helper/timeSeries.dart';
import 'package:CoronaNotifier/API/myAPI.dart';

import 'dart:convert';

class TimeData {
  List<TimeSeries> affectedData = new List<TimeSeries>();
  List<TimeSeries> deathData = new List<TimeSeries>();

  Future<void> getTimeData() async {
    var response = await http.get(timeseries_url, headers: {
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['US'].forEach((s) {
        DateTime date = new DateFormat('MM/dd/yyyy').parse(s['date']);
        int affected = s['affected'];
        int deaths = s['deaths'];
        TimeSeries affectedTimeSeriesData = TimeSeries(date: date, data: affected);
        TimeSeries deathTimeSeriesData = TimeSeries(date: date, data: deaths);
        affectedData.add(affectedTimeSeriesData);
        deathData.add(deathTimeSeriesData);
      });
    } else {
      affectedData = null;
      deathData = null;
    }
  }
}