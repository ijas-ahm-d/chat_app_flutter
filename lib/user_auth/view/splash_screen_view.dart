import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/home/view/home_screen.dart';
import 'package:chat_app/user_auth/view/login_screen_view.dart';
import 'package:chat_app/utils/global_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loggedIn(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
        return AnimatedSplashScreen(
          splash: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("CHAT_APP")],
          ),
          nextScreen: snapshot.data!,
          splashTransition: SplashTransition.fadeTransition,
        );
      },
    );
  }

  Future<Widget> loggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(GlobalKeys.userLoggedInLey) ?? false;
    if (isLoggedIn) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
