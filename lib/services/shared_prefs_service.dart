import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<void> saveToken(String token) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('token', token);
    } catch (error) {
      print("error while saving token");
      print(error.toString());
    }
  }

  static Future<String> getToken() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString('token');
    } catch (error) {
      print("error while saving token");
      print(error.toString());
      return 'error';
    }
  }
}
