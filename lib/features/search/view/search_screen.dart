// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/core/common/widgets/loader.dart';
import 'package:amazon_clone/features/search/controller/search_controller.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({required this.searchQuery, super.key});
  static const String routeName = '/search-screen';
  final String searchQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ref.watch(searchProductsProvider(widget.searchQuery)).when(
            data: (products) => ListView.builder(
                  itemBuilder: ((context, index) {
                    return Text(products[index].name);
                  }),
                  itemCount: products.length,
                ),
            error: (e, tr) => Center(
                  child: Text(e.toString()),
                ),
            loading: () => const Loader()));
  }
}
