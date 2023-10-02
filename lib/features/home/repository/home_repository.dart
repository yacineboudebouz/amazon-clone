import 'dart:convert';

import 'package:amazon_clone/core/providers/api_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';

import 'package:amazon_clone/models/product.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

import '../../../core/constants/error_handling.dart';

final homeRepositoryProvider = Provider((ref) {
  return HomeRepository(ref);
});

class HomeRepository {
  final Ref _ref;
  HomeRepository(Ref ref) : _ref = ref;

  Future<List<Product>> fetchCategoryProducts(String category) async {
    try {
      final user = _ref.watch(userProvider).user;
      List<Product> productList = [];

      http.Response res = await http.get(
        Uri.parse(
          '${ApiProvider.uri}/api/products?category=$category',
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
            productList
                .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );

      return productList;
    } catch (e) {
      print('Something went wrong');
      return [];
    }
  }
}
