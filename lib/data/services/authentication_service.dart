import 'dart:convert';

import 'package:http/http.dart' as http;
import './shared_prefs_service.dart';

const String _authenticationLink =
    "https://matrica.hr:5700/api/auth/create_token";

class AuthenticationService {
  Future<void> login() async {
    try {
      final http.Response _response = await http.post(
        _authenticationLink,
        body:
            json.encode({'username': "korina", 'password': "/()789uioUIOUIO"}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );

      await SharedPreferencesService.saveToken(
          json.decode(_response.body)['Token']);

      final String _token = await SharedPreferencesService.getToken();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
