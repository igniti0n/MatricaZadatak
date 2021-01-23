import 'dart:convert';
import 'dart:developer';

import '../models/agent.dart';

import 'package:MatricaZadatak/services/shared_prefs_service.dart';
import 'package:http/http.dart' as http;

class DataProviderService {
  Future<List<Agent>> getData(DateTime startDate, bool isUpper) async {
    try {
      final DateTime _endDateUpper = startDate.add(Duration(days: 4));
      final DateTime _endDateLower = startDate.add(Duration(days: 8));

      final _upperDataLink =
          "https://matrica.hr:5700/api/AndroidTV/Upper?startDate=${startDate.year}-${startDate.month}-${startDate.day}&endDate=${_endDateUpper.year}-${_endDateUpper.month}-${_endDateUpper.day}";

      final _lowerDataLink =
          "https://matrica.hr:5700/api/AndroidTV/Lower?startDate=${startDate.year}-${startDate.month}-${startDate.day}&endDate=${_endDateLower.year}-${_endDateLower.month}-${_endDateLower.day}";

      final String _token = await SharedPreferencesService.getToken();
      print("TOKEN BURAZ: $_token");

      final http.Response _response = await http.get(
        isUpper ? _upperDataLink : _lowerDataLink,
        headers: {
          'Content-type': 'application/x-www-form-urlencoded',
          'www-authenticate': _token,
          "Authorization": "Bearer $_token",
          // 'Authorization': '',
        },
      );

      log(isUpper
          ? "UPPER DATA RESPONSE: ${_response.body}"
          : "LOWER DATA RESPONSE: ${_response.body}");

      final List<Agent> _agents = (jsonDecode(_response.body) as List<dynamic>)
          .map((agent) => Agent.fromMap(agent))
          .toList();

      // print(_agents[0].toString());
      return _agents;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Future<List<Agent>> getUpperData(DateTime startDate) async {
  //   try {
  //     final DateTime _endDate = startDate.add(Duration(days: 4));

  //     final _upperDataLink =
  //         "https://matrica.hr:5700/api/AndroidTV/Upper?startDate=${startDate.year}-${startDate.month}-${startDate.day}&endDate=${_endDate.year}-${_endDate.month}-${_endDate.day}";

  //     final String _token = await SharedPreferencesService.getToken();
  //     print("TOKEN BURAZ: $_token");

  //     final http.Response _response = await http.get(
  //       _upperDataLink,
  //       headers: {
  //         'Content-type': 'application/x-www-form-urlencoded',
  //         'www-authenticate': _token,
  //         "Authorization": "Bearer $_token",
  //         // 'Authorization': '',
  //       },
  //     );

  //     log("UPPER DATA RESPONSE: ${_response.body}");

  //     final filename = 'file.txt';

  //     final List<Agent> _agents = (jsonDecode(_response.body) as List<dynamic>)
  //         .map((agent) => Agent.fromMap(agent))
  //         .toList();

  //     print(_agents[0].toString());
  //     return _agents;
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  // Future<List<Agent>> getLowerData(DateTime startDate) async {
  //   final DateTime _endDate = startDate.add(Duration(days: 4));
  //   try {
  //     final _lowerDataLink =
  //         "https://matrica.hr:5700/api/AndroidTV/Lower?startDate=${startDate.year}-${startDate.month}-${startDate.day}&endDate=${_endDate.year}-${_endDate.month}-${_endDate.day}";

  //     final String _token = await SharedPreferencesService.getToken();
  //     print("TOKEN BURAZ: $_token");

  //     final http.Response _response = await http.get(
  //       _lowerDataLink,
  //       headers: {
  //         'Content-type': 'application/x-www-form-urlencoded',
  //         'www-authenticate': _token,
  //         "Authorization": "Bearer $_token",
  //       },
  //     );

  //     log("LOWER DATA RESPONSE: ${_response.body}");
  //     final List<dynamic> _agentsString =
  //         jsonDecode(_response.body) as List<dynamic>;

  //     final List<Agent> _agents = (jsonDecode(_response.body) as List<dynamic>)
  //         .map((agent) => Agent.fromMap(agent))
  //         .toList();

  //     print(_agents[0].toString());
  //     return _agents;
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }
}
