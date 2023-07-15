import 'dart:developer';

import 'package:chat_app/data/network/database_service.dart';
import 'package:chat_app/user_auth/components/common_snackbar.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_keys.dart';
import 'package:chat_app/utils/routes/navigations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupViewModel extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  clearController() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future register(BuildContext context) async {
    setLoading(true);
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text))
          .user;
      if (user != null) {
        setLoading(false);
        // call our database service to update the user data
        // ignore: use_build_context_synchronously
        await DatabaseService(uid: user.uid).savingUserData(context);

        await setSignupStatus(
            userName: userNameController.text.trim(),
            usesrEmail: emailController.text.trim());

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed(Navigations.homeScreen);

        clearController();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      log(e.toString());
      return CommonSnackBAr.snackBar(
        context: context,
        data: e.message.toString(),
        color: AppColors.warn,
      );
    }
    setLoading(false);
  }

  setSignupStatus(
      {required String userName, required String usesrEmail}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    await sf.setBool(GlobalKeys.userLoggedInLey, true);
    await sf.setString(GlobalKeys.userNameKey, userName);
    await sf.setString(GlobalKeys.userEmailKey, usesrEmail);
  }

  setLogOutStatus(BuildContext context) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    await sf.setBool(GlobalKeys.userLoggedInLey, false);
    await sf.setString(GlobalKeys.userNameKey, "");
    await sf.setString(GlobalKeys.userEmailKey, "");

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(Navigations.splashScreen);
  }
}
