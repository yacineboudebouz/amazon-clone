import 'package:amazon_clone/core/constants/error_handling.dart';
import 'package:amazon_clone/core/constants/utils.dart';
import 'package:amazon_clone/core/providers/api_provider.dart';

import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/models/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final adminRepositoryProvider = Provider((ref) {
  return AdminRepository(ref: ref);
});

class AdminRepository {
  AdminRepository({required Ref ref}) : _ref = ref;

  final Ref _ref;
  Future sellProduct({
    required BuildContext context,
    required Product product,
  }) async {
    try {
      final user = _ref.watch(userProvider);

      http.Response response = await http.post(
        Uri.parse('${ApiProvider.uri}/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token,
        },
        body: product.toJson(),
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added successfully !', Colors.green);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }
}
