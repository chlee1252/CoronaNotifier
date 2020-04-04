import 'package:http/http.dart' as http;
import 'dart:convert';

class CountyService {

  CountyService(this.uri);

  final String uri;
  int affected;
  int deaths;
  int newAffected;
  int newDeaths;
  String date;

  Future<void> getCountyData() async {
    var response = await http.get(uri, headers: {
      "Accept": "application/json",
    });

    if (response.statusCode == 200) {
      var countyData = jsonDecode(response.body);

      if (countyData != null) {
        affected = countyData['Confirmed'];
        deaths = countyData['Deaths'];
        date = countyData['Last Update'];
        newAffected = countyData['New Confirmed'];
        newDeaths = countyData['New Death'];
      }
    }

  }


}
