// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/core/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/view/widgets/adress_box.dart';
import 'package:amazon_clone/features/search/controller/search_controller.dart';
import 'package:amazon_clone/features/search/view/widgets/searched_products.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/global_variables.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({required this.searchQuery, super.key});
  static const String routeName = '/search-screen';
  final String searchQuery;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic, color: Colors.black, size: 25),
                ),
              ],
            ),
          ),
        ),
        body: ref.watch(searchProductsProvider(widget.searchQuery)).when(
            data: (products) => Column(
                  children: [
                    const AdressBox(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(
                              //   context,
                              //   ProductDetailScreen.routeName,
                              //   arguments: products![index],
                              // );
                            },
                            child: SearchedProduct(
                              product: products[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
            error: (e, tr) => Center(
                  child: Text(e.toString()),
                ),
            loading: () => const Loader()));
  }
}
