import 'package:http/http.dart' as http;
import 'dart:convert';

import '../helper/detailInfo.dart';
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
        String name = s['County'];
        int active = s['Confirmed'];
        int deaths = s['Deaths'];
        String date = s['Last Update'];
        int newActive = s['New Confirmed'];
        int newDeaths = s['New Death'];
        DetailInfo temp = DetailInfo(
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