import 'package:amazon_clone/features/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      ref: ref, authRepository: ref.watch(authRepositoryProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required Ref ref, required AuthRepository authRepository})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    state = true;
    _authRepository.signUpUser(
      context: context,
      email: email,
      password: password,
      name: name,
    );
    state = false;
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    _authRepository.signInUser(
      context: context,
      email: email,
      password: password,
    );
    state = false;
  }

  void getUserData(BuildContext context) async {
    state = true;
    _authRepository.getUserData(context);
    state = false;
  }
}
