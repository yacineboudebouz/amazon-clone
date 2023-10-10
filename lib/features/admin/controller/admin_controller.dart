import 'dart:io';

import 'package:amazon_clone/features/admin/repository/admin_repository.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/cloudinary_provider.dart';
import '../../../models/rating.dart';

final adminControllerProvider = ChangeNotifierProvider((ref) {
  return AdminController(
      adminRepository: ref.read(adminRepositoryProvider), ref: ref);
});
final allProducts = FutureProvider.family((ref, BuildContext context) async {
  final adminController = ref.read(adminControllerProvider.notifier);
  return adminController.getAllProducts(context);
});

class AdminController extends ChangeNotifier {
  AdminController({required AdminRepository adminRepository, required Ref ref})
      : _adminRepository = adminRepository,
        _ref = ref;
  final AdminRepository _adminRepository;
  final Ref _ref;

  List<Product> _products = [];
  List<Product> get products => _products;

  void addProduct({
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    required BuildContext context,
    required List<Rating> rating,
  }) async {
    try {
      final cloudinary = _ref.watch(cloudinaryProvider);

      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
        rating: rating,
      );
      if (context.mounted) {
        await _adminRepository.sellProduct(context: context, product: product);
      }

      _products.add(product);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Product>> getAllProducts(BuildContext context) async {
    List<Product> products = [];
    try {
      products = await _adminRepository.fetchAllProducts(context);
    } catch (e) {
      debugPrint(e.toString());
    }
    _products = products;
    notifyListeners();
    return products;
  }

  void deleteProduct(
      String id, BuildContext context, VoidCallback onSucess) async {
    await _adminRepository.deleteProduct(id, context, onSucess);
    await _adminRepository.fetchAllProducts(context);
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
