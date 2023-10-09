import 'package:amazon_clone/features/search/repository/search_repository.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchControllerProvider = StateNotifierProvider((ref) {
  return SearchController(ref, ref.read(searchRepositoryProvider));
});

final searchProductsProvider = FutureProvider.family((ref, String query) async {
  return ref.read(searchControllerProvider.notifier).getProductsCategory(query);
});

class SearchController extends StateNotifier<List<Product>> {
  final Ref _ref;
  final SearchRepository _searchRepository;
  SearchController(Ref ref, SearchRepository searchRepository)
      : _ref = ref,
        _searchRepository = searchRepository,
        super([]);

  Future<List<Product>> getProductsCategory(String query) async {
    state = await _searchRepository.fetchSearchProduct(query);
    return state;
  }
}
