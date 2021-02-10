import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import './shared_prefs_service.dart';

const String
    _authenticationLink = //"https://matrica.hr:6400/Auth/create_token";
    "https://salvis.hr:4700/api/auth/create_token";

class AuthenticationService {
  Future<void> login() async {
    try {
      final http.Response _response = await http.post(
        _authenticationLink,
        body: json
            .encode({'username': "ivan", 'password': "Kruno Denis Ivan \$321"}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );
      log(_response.body);
      await SharedPreferencesService.saveToken(
          json.decode(_response.body)['Token']);

      final String _token = await SharedPreferencesService.getToken();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
