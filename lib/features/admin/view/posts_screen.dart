import 'package:amazon_clone/features/admin/controller/admin_controller.dart';
import 'package:amazon_clone/features/admin/view/add_product_screen.dart';
import 'package:amazon_clone/features/admin/view/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  Future? _productsList;
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future _getAllProducts() async {
        return await ref.watch(adminControllerProvider).getAllProducts(context);
      }

      _productsList = _getAllProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _productsList,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong !'),
                );
              } else {
                var products = ref.watch(adminControllerProvider).products;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return ProductTile(
                        product: products[index],
                        onSuccess: () {
                          products.removeAt(index);
                        },
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
