import 'dart:convert';

import 'package:amazon_clone/core/constants/utils.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      print('404 error');
      break;
    case 500:
      print('500 error');
      break;
    default:
      print('Somthing went wrong');
  }
}
