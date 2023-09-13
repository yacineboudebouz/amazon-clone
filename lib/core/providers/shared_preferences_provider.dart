// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider((ref) async {
  var prefs = await SharedPreferences.getInstance();
  return SharedPreferencesProvider(prefs);
});

class SharedPreferencesProvider {
  final String tokenKey = 'x-auth-token';
  final SharedPreferences _sharedPreferences;
  SharedPreferencesProvider(
    SharedPreferences sharedPreferences,
  ) : _sharedPreferences = sharedPreferences;

  void storeToken(String token) {
    _sharedPreferences.setString(tokenKey, token);
  }

  String getToken() {
    return _sharedPreferences.getString(tokenKey)!;
  }
}
