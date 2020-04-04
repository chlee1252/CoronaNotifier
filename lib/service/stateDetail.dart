import 'package:http/http.dart' as http;
import 'dart:convert';

import '../helper/detailInfo.dart';

class StateDetail {
  StateDetail({this.url});

  List detailData = new List();
  final String url;

  Future<void> getDetailData() async {
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      data.forEach((s) {
        var name = s['County'];
        var active = s['Confirmed'];
        var deaths = s['Deaths'];
        var date = s['Last Update'];
        var newActive = s['New Confirmed'];
        var newDeaths = s['New Death'];
        var temp = DetailInfo(
            active: active,
            death: deaths,
            newActive: newActive,
            newDeath: newDeaths,
            county: name,
            date: date);
        detailData.add(temp);
      });
    } else {
      detailData = null;
    }

}


}