import 'package:chat_app/data/network/database_service.dart';
import 'package:chat_app/user_auth/components/common_snackbar.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  TextEditingController groupNameController = TextEditingController();

  createGroup(BuildContext context, String userName) {
    Navigator.pop(context);
    setLoading(true);
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).createGroup(
      userName,
      FirebaseAuth.instance.currentUser!.uid,
      groupNameController.text.trim(),
    );

    clearController();
    setLoading(false);
    CommonSnackBAr.snackBar(
      context: context,
      data: "Group created succesfully",
      color: AppColors.spGreen,
    );
  }

  clearController() {
    groupNameController.clear();
  }
}
