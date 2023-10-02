import 'package:amazon_clone/features/home/repository/home_repository.dart';
import 'package:amazon_clone/models/product.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, List<Product>>((ref) {
  return HomeController(ref, ref.watch(homeRepositoryProvider));
});

final productsCategoryProvider =
    FutureProvider.family((ref, String category) async {
  final homeController = ref.read(homeControllerProvider.notifier);
  return homeController.getProductsCategory(category);
});

class HomeController extends StateNotifier<List<Product>> {
  final Ref _ref;
  final HomeRepository _homeRepository;
  HomeController(Ref ref, HomeRepository homeRepository)
      : _ref = ref,
        _homeRepository = homeRepository,
        super([]);

  Future<List<Product>> getProductsCategory(String category) async {
    print(1);
    state = await _homeRepository.fetchCategoryProducts(category);
    print(2);
    return state;
  }
}
