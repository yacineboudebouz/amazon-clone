import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider((ref) {
  return UserProvider();
});

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      email: '',
      name: '',
      password: '',
      address: '',
      type: '',
      token: '');
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
