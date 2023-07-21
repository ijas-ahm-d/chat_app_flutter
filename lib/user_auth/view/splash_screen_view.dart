import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/home/view/home_screen.dart';
import 'package:chat_app/user_auth/view/login_screen_view.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_keys.dart';
import 'package:chat_app/utils/global_values.dart';
import 'package:chat_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    final size = MediaQuery.of(context).size;
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
          backgroundColor: AppColors.kwhite,
          splashIconSize: double.infinity,
          duration: 3000,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TEAM-TALK",
                style: TextStyles.splashHead(),
              ),
              AppSizes.kHeight20,
              SizedBox(
                width: size.width * 0.8,
                child: Image.asset("assets/images/chatApp.png"),
              ),
            ],
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
     
      return  const HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
