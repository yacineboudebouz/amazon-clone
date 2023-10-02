import 'dart:convert';
import 'package:amazon_clone/core/constants/utils.dart';
import 'package:amazon_clone/core/providers/api_provider.dart';
import 'package:amazon_clone/core/providers/shared_preferences_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/error_handling.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ref);
});

class AuthRepository {
  final Ref _ref;
  AuthRepository(Ref ref) : _ref = ref;
  Future signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );
      http.Response res = await http.post(
          Uri.parse('${ApiProvider.uri}/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          onSuccess: () {
            showSnackBar(
                context,
                'Account created! Login with the same credentials !',
                Colors.green);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Something went wrong!', Colors.red);
      }
    }
  }

  Future signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${ApiProvider.uri}/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            onSuccess: () async {
              final prefs = await _ref.read(sharedPreferencesProvider);
              prefs.storeToken(jsonDecode(res.body)['token']);
              _ref.watch(userProvider).setUser(res.body);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Something went wrong!', Colors.red);
      }
    }
  }

  Future getUserData(BuildContext context) async {
    try {
      final prefs = await _ref.read(sharedPreferencesProvider);
      String? token = prefs.getToken();

      // ignore: unnecessary_null_comparison
      if (token == null) {
        prefs.storeToken('');
      }
      var tokenRes = await http.post(
          Uri.parse('${ApiProvider.uri}/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        // get user data
        http.Response userRes = await http
            .get(Uri.parse('${ApiProvider.uri}/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        var user = _ref.read(userProvider);
        user.setUser(userRes.body);
      }
    } catch (e) {
      // showSnackBar(context, e.toString(), Colors.red);
    }
  }
}
