import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = 'auth-screen';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Auth Screen '),
      ),
    );
  }
}
