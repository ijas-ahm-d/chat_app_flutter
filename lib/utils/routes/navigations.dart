import 'package:chat_app/user_auth/view/login_screen_view.dart';
import 'package:chat_app/user_auth/view/signup_screen_view.dart';
import 'package:chat_app/user_auth/view/splash_screen_view.dart';
import 'package:flutter/material.dart';

class Navigations {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const loginScreen = "/userLogin";
  static const signupScreen = "/userSignup";
  static const splashScreen = "/splash_screen";

  static Map<String, Widget Function(BuildContext)> routes() {
    Map<String, Widget Function(BuildContext)> routes = {
      "/splash_screen": (context) => const SplashScreen(),
      "/userLogin": (context) => const LoginScreen(),
      "/userSignup": (context) => const SignupScreen(),
    };
    return routes;
  }
}
