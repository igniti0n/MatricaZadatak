import 'dart:convert';

import 'package:http/http.dart' as http;
import './shared_prefs_service.dart';

const String _authenticationLink =
    "https://matrica.hr:5700/api/auth/create_token";

//TODO: POKUSAJ PRVO SE PONOVO LOGIRAT AKO IMA VEC TOKEN

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
      print("SPREMLJENI TOKEN::::::::");
      final String _token = await SharedPreferencesService.getToken();
      print(_token);
      print(":::::::::::::::::::::::");

      print("RESPONSE BODY: ${_response.body}");
    } catch (error) {
      print("NEKI ERROR");
      print(error.toString());
    }
  }
}
