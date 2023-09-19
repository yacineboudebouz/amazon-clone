import 'package:amazon_clone/core/constants/global_variables.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [],
          );
        },
        itemCount: GlobalVariables.categoryImages.length,
      ),
    );
  }
}
