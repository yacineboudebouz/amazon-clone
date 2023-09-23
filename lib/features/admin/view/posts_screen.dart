import 'package:amazon_clone/core/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/controller/admin_controller.dart';
import 'package:amazon_clone/features/admin/view/add_product_screen.dart';
import 'package:amazon_clone/features/admin/view/widgets/product_tile.dart';
import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ref.watch(allProducts(context)).when(
          data: (data) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return ProductTile(product: data[index]);
                  },
                  itemCount: data.length,
                ),
              ),
          error: (e, tr) => Center(
                child: Text(e.toString()),
              ),
          loading: () => const Loader()),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
