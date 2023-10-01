// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amazon_clone/core/constants/global_variables.dart';

class CategoryDealsScreen extends ConsumerStatefulWidget {
  static const String routeName = '/category-deals';
  const CategoryDealsScreen({
    required this.category,
    super.key,
  });
  final String category;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends ConsumerState<CategoryDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep shopping for ${widget.category}',
            ),
          )
        ],
      ),
    );
  }
}
