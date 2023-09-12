import 'dart:convert';

import 'package:amazon_clone/core/constants/utils.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg'], Colors.red);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error'], Colors.red);
      break;
    default:
      showSnackBar(
          context, '${response.body}  Something went wrong!', Colors.red);
  }
}
