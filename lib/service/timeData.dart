import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert';

import '../helper/timeSeries.dart';
import '../geoAPI/myAPI.dart';

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
        var date = new DateFormat('MM/dd/yyyy').parse(s['date']);
        var affected = s['affected'];
        var deaths = s['deaths'];
        var affected_data = TimeSeries(date: date, data: affected);
        var death_data = TimeSeries(date: date, data: deaths);
        affectedData.add(affected_data);
        deathData.add(death_data);
      });
    } else {
      affectedData = null;
      deathData = null;
    }
  }
}