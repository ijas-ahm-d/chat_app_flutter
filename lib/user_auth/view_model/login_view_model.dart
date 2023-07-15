import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? _userEmail;
  String? get userEmail => _userEmail;

  bool _passwordVisibility = true;
  bool get passwordVisibility => _passwordVisibility;

 showPassword() {
    _passwordVisibility = !passwordVisibility;
    notifyListeners();
  }
}
