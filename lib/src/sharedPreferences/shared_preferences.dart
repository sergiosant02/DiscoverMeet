import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _singleton = UserPreferences._internal();

  factory UserPreferences() {
    return _singleton;
  }
  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String email) {
    _prefs.setString('email', email);
  }

  String get password {
    return _prefs.getString('password') ?? '';
  }

  set password(String password) {
    _prefs.setString('password', password);
  }

  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String token) {
    _prefs.setString('token', token);
  }
}
