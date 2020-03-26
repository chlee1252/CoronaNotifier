import 'package:http/http.dart' as http;
import 'dart:convert';

class UserCounty {

  UserCounty(this.uri);

  final String uri;
  String county;
  String code;
  String state;
  String countyFIP;

  Future<void> getCounty() async {
    var response = await http.get(uri, headers: {
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      var  data = jsonDecode(response.body);
      if (data['results'].length != 0) {
        county = data['results'][0]['county_name'];
        code = data['results'][0]['state_code'];
        state = data['results'][0]['state_name'];
        countyFIP = data['results'][0]['county_fips'];
      } else {
        countyFIP = "1";
      }
    }
  }
}