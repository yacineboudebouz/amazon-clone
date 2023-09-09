import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          color: GlobalVariables.secondaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        useMaterial3: true,
      ),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          return loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
