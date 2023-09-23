import 'package:amazon_clone/features/account/view/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/controller/admin_controller.dart';
import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/product.dart';

class ProductTile extends ConsumerWidget {
  const ProductTile(
      {super.key, required this.product, required this.onSuccess});
  final Product product;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: SingleProduct(image: product.images[0]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSuccess;
                    ref
                        .watch(adminControllerProvider.notifier)
                        .deleteProduct(product.id!, context, onSuccess);
                  },
                  icon: const Icon(Icons.delete_outline))
            ],
          ),
        )
      ],
    );
  }
}
