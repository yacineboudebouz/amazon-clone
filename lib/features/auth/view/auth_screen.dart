// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:amazon_clone/core/common/widgets/custom_button.dart';
import 'package:amazon_clone/core/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/core/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/controller/auth_controller.dart';

enum Auth { signIn, signUp }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({
    required this.loading,
  });
  final bool loading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // late Animation<Offset> slideAnimation;
  // late AnimationController controller;

  // @override
  // void initState() {
  //   controller =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 1));
  //   slideAnimation = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
  //       .animate(controller);
  //   super.initState();
  // }

  void signUpUser() {
    ref.read(authControllerProvider.notifier).signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        context: context);
  }

  void signInUser() {
    ref.read(authControllerProvider.notifier).signInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: widget.loading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      tileColor: _auth == Auth.signUp
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundCOlor,
                      title: const Text(
                        'Create Account',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signUp,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                    if (_auth == Auth.signUp)
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: _signUpFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _nameController,
                                hintText: 'Name',
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                text: 'Sign Up',
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ListTile(
                      tileColor: _auth == Auth.signIn
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundCOlor,
                      title: const Text(
                        'Sign-in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signIn,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                    if (_auth == Auth.signIn)
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: _signInFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _emailController,
                                hintText: 'Email',
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: 'Password',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                text: 'Sign In',
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              )));
  }
}
