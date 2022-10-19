import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper(this.city);
  final String city;

  Future call_api() async {
    String url = "https://weatherapi-com.p.rapidapi.com/current.json?q=${city}";
    Map<String, String> headers = {
      "X-RapidAPI-Key": "893db5ab43msh634e3bab9fb82d2p127793jsn587cd91162ae",
      "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
    };

    var resp = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (resp.statusCode == 200) {
      // print(resp.body);
      return jsonDecode(resp.body);
    } else
      return {'error': true};
  }
}
