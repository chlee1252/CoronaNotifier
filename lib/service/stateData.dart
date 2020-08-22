import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:CoronaNotifier/API/myAPI.dart';
import 'package:CoronaNotifier/helper/stateInfo.dart';

class StateData {
  List stateData = new List();

  Future<void> getStateData() async {
      var response = await http.get(state_url, headers: {
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        data.forEach((s) {
          String name = s['state'];
          int active = s['Confirmed'];
          int deaths = s['Deaths'];
          int recovered = 0;
          String date = s['Last Update'];
          int newActive = s['New Confirmed'];
          int newDeaths = s['New Death'];
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
