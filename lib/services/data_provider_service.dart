import 'dart:convert';

import '../models/agent.dart';

import 'package:MatricaZadatak/services/shared_prefs_service.dart';
import 'package:http/http.dart' as http;

const _upperDataLink =
    "https://matrica.hr:5700/api/AndroidTV/Upper?startDate=2020-12-21&endDate=2020-12-25";

const _lowerDataLink =
    "https://matrica.hr:5700/api/AndroidTV/Lower?startDate=2020-12-21&endDate=2020-12-25";

class DataProviderService {
  Future<List<Agent>> getUpperData() async {
    try {
      final String _token = await SharedPreferencesService.getToken();
      print("TOKEN BURAZ: $_token");

      final http.Response _response = await http.get(
        _upperDataLink,
        headers: {
          'Content-type': 'application/x-www-form-urlencoded',
          'www-authenticate': _token,
          "Authorization": "Bearer $_token",
          // 'Authorization': '',
        },
      );

      // print("UPPER DATA RESPONSE: ${_response.body}");

      final List<Agent> _agents = (jsonDecode(_response.body) as List<dynamic>)
          .map((agent) => Agent.fromMap(agent))
          .toList();

      print(_agents[0].toString());
      return _agents;
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<Agent>> getLowerData() async {
    try {
      final String _token = await SharedPreferencesService.getToken();
      print("TOKEN BURAZ: $_token");

      final http.Response _response = await http.get(
        _lowerDataLink,
        headers: {
          'Content-type': 'application/x-www-form-urlencoded',
          'www-authenticate': _token,
          "Authorization": "Bearer $_token",
        },
      );

      //  print("LOWER DATA RESPONSE: ${_response.body}");
      // final List<dynamic> _agentsString =
      //     jsonDecode(_response.body) as List<dynamic>;

      final List<Agent> _agents = (jsonDecode(_response.body) as List<dynamic>)
          .map((agent) => Agent.fromMap(agent))
          .toList();

      print(_agents[0].toString());
      return _agents;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
