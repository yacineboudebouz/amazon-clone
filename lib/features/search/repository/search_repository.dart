import 'dart:convert';

import 'package:amazon_clone/core/constants/error_handling.dart';
import 'package:amazon_clone/core/providers/api_provider.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../core/providers/user_provider.dart';

final searchRepositoryProvider = Provider((ref) {
  return SearchRepository(ref);
});

class SearchRepository {
  final Ref _ref;
  SearchRepository(Ref ref) : _ref = ref;

  Future<List<Product>> fetchSearchProduct(String searchQuery) async {
    try {
      final user = _ref.watch(userProvider).user;
      List<Product> productList = [];

      http.Response res = await http.get(
        Uri.parse(
          '${ApiProvider.uri}/api/products/search/$searchQuery',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
      );

      httpErrorHandle(
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
      return productList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
