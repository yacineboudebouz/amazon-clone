import 'package:amazon_clone/core/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/core/constants/global_variables.dart';
import 'package:amazon_clone/core/loading.dart';

import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/admin/view/admin_screen.dart';
import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:amazon_clone/features/auth/view/auth_screen.dart';
import 'package:amazon_clone/router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      void getData(WidgetRef ref) {
        ref.read(authControllerProvider.notifier).getUserData(context);
      }

      getData(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final isLoading = ref.watch(authControllerProvider);
    return MaterialApp(
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
      onGenerateRoute: (settings) => generateRoute(settings),
      home: user.user.token.isEmpty
          ? AuthScreen(loading: isLoading)
          : user.user.type == 'admin'
              ? const AdminScreen()
              : const BottomBar(),
    );
  }
}
