import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  static AppPreferences? _appPreferences;
  SharedPreferences? _prefs;
  static const LOGIN_KEY = "login_key";
  static const ACCESS_TOKEN_KEY = "access_token";
  static Future<AppPreferences> init() async {
    if(_appPreferences==null) {
      _appPreferences = AppPreferences();
      _appPreferences!._prefs = await SharedPreferences.getInstance();
    }
    return _appPreferences!;
  }

  bool checkLogin() {
    return _prefs!.getBool(LOGIN_KEY)??false;
  }

  Future<void> saveLoginMode(bool value) async {
    await _prefs!.setBool(LOGIN_KEY, value);
  }

  saveAccessToken(String token) async {
    await _prefs!.setString(ACCESS_TOKEN_KEY, token);
  }

  String getAccessToken() {
    return _prefs!.getString(ACCESS_TOKEN_KEY)??"";
  }
}