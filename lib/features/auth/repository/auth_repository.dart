import 'package:amazon_clone/core/constants/utils.dart';

import 'package:amazon_clone/core/providers/api_provider.dart';

import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

import '../../../core/constants/error_handling.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository();
});

class AuthRepository {
  void signUpUser({
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
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context,
              'Account created! Login with the same credentials !',
              Colors.green);
        },
      );
    } catch (e) {
      showSnackBar(context, 'Something went wrong!', Colors.red);
    }
  }
}
