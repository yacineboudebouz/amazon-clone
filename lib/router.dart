import 'package:amazon_clone/features/auth/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {'/': (_) => const MaterialPage(child: AuthScreen())},
);
