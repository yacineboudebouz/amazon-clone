import 'package:amazon_clone/features/admin/view/add_product_screen.dart';
import 'package:amazon_clone/features/home/view/category_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(category: category));
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Ops No Route '),
          ),
        ),
      );
  }
}
