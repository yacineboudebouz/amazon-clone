import 'package:amazon_clone/core/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/auth/view/auth_screen.dart';
import 'package:amazon_clone/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: AuthScreen()),
    '/home': (_) => const MaterialPage(child: HomeScreen())
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: BottomBar()),
  },
);
