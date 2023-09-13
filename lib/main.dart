import 'package:amazon_clone/core/constants/global_variables.dart';
import 'package:amazon_clone/core/providers/shared_preferences_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();

  Future getData(ProviderContainer ref) {
    return ref.read(authControllerProvider.notifier).getUserData();
  }

  await getData(container);
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
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
          return ref.watch(userProvider).user.token.isNotEmpty
              ? loggedInRoute
              : loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
