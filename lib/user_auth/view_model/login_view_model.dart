import 'dart:developer';

import 'package:chat_app/data/network/database_service.dart';
import 'package:chat_app/user_auth/components/common_snackbar.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:chat_app/utils/global_keys.dart';
import 'package:chat_app/utils/routes/navigations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String? _userEmail;
  String? get userEmail => _userEmail;

  bool _passwordVisibility = true;
  bool get passwordVisibility => _passwordVisibility;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  showPassword() {
    _passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
  }

  Future login(BuildContext context) async {
    setLoading(true);
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text))
          .user;
      if (user != null) {
        setLoading(false);
        // call our database service to update the user data
        // ignore: use_build_context_synchronously
      QuerySnapshot snapshot=  await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .gettingUserData(context);
        await setLoginStatus(
            userName: snapshot.docs[0]['fullName'],
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

  setLoginStatus({required String usesrEmail,required String userName}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    await sf.setBool(GlobalKeys.userLoggedInLey, true);
    await sf.setString(GlobalKeys.userNameKey, userName);
    await sf.setString(GlobalKeys.userEmailKey, usesrEmail);
  }
}
