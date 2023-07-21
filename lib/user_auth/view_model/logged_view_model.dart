import 'package:chat_app/data/network/database_service.dart';
import 'package:chat_app/utils/global_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedInViewModel extends ChangeNotifier {
  String? _userID;
  String? get userID => _userID;

  String? _userName;
  String? get userName => _userName;

  String? _userEmail;
  String? get userEmail => _userEmail;

  Stream? _groups;
  Stream? get groups => _groups;

  getUserId(String? id) {
    _userID = id;
    notifyListeners();
  }

  getUserEmail(String? email) {
    _userEmail = email;
    notifyListeners();
  }

  getUserName(String? name) {
    _userName = name;
    notifyListeners();
  }

  getUserGroups(Stream? stream) {
    _groups = stream;
    notifyListeners();
  }

  getUserDetails() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? name = sf.getString(GlobalKeys.userNameKey);
    String? email = sf.getString(GlobalKeys.userEmailKey);
    String? userId = sf.getString(GlobalKeys.userId);
    getUserEmail(email);
    getUserName(name);
    getUserId(userId);

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      getUserGroups(snapshot);
    });
  }
}
