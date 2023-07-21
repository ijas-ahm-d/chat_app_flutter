import 'package:chat_app/data/network/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupViewModel extends ChangeNotifier {
  Stream? _members;
  Stream? get members => _members;

  setMembers(Stream? data) {
    _members = data;
    notifyListeners();
  }

  getMembers(String groupID) {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getMembers(groupID)
        .then((value) => setMembers(value));
  }

  String getName(String str) {
    return str.substring(str.indexOf("_")+1);
  }
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }
}
