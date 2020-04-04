import 'package:http/http.dart' as http;
import 'dart:convert';

import '../geoAPI/myAPI.dart';
import '../helper/stateInfo.dart';

class StateData {
  List stateData = new List();

  Future<void> getStateData() async {
//    var response;
      var response = await http.get(state_url, headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        data.forEach((s) {
          var name = s['state'];
          var active = s['Confirmed'];
          var deaths = s['Deaths'];
          var recovered = 0;
          var date = s['Last Update'];
          var newActive = s['New Confirmed'];
          var newDeaths = s['New Death'];
          var temp = StateInfo(
              active: active,
              death: deaths,
              recovered: recovered,
              newActive: newActive,
              newDeath: newDeaths,
              state: name,
              date: date);
          stateData.add(temp);
        });
      } else {
        stateData = null;
      }
  }
}
