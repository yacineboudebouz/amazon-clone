import 'dart:io';

import 'package:amazon_clone/features/admin/repository/admin_repository.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/cloudinary_provider.dart';

final adminControllerProvider =
    StateNotifierProvider<AdminController, bool>((ref) {
  return AdminController(
      adminRepository: ref.read(adminRepositoryProvider), ref: ref);
});

class AdminController extends StateNotifier<bool> {
  AdminController({required AdminRepository adminRepository, required Ref ref})
      : _adminRepository = adminRepository,
        _ref = ref,
        super(false);
  final AdminRepository _adminRepository;
  final Ref _ref;

  void addProduct({
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    required BuildContext context,
  }) async {
    try {
      state = true;
      final cloudinary = _ref.watch(cloudinaryProvider);
      print('1');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      print('2');
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      // ignore: use_build_context_synchronously
      await _adminRepository.sellProduct(context: context, product: product);
      print('3');
      state = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
