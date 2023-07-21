import 'package:chat_app/data/network/database_service.dart';
import 'package:chat_app/user_auth/components/common_snackbar.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController groupNameController = TextEditingController();

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _groupName;
  String? get groupName => _groupName;

  String? _groupAdmin;
  String? get groupAdmin => _groupAdmin;

  Stream<QuerySnapshot>? _chats;
  Stream<QuerySnapshot>? get chats => _chats;

  setSearch() {
    _isSearch = !_isSearch;
    notifyListeners();
  }

  setGroupAdmin(String? admin) {
    _groupAdmin = admin;
    notifyListeners();
  }

  setLoading(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  setGroupName(String name) {
    _groupName = name;
    notifyListeners();
  }

  setChats(Stream<QuerySnapshot>? chat) {
    _chats = chat;
    notifyListeners();
  }

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

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  getGroupName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }
  String getAdminName(String str) {
    return str.substring(str.indexOf("_")+1);
  }

  getChatsandAdmin(String groupId) {
    DatabaseService().getChats(groupId).then((val) {
      setChats(val);
    });

    DatabaseService()
        .getGroupAdmin(groupId)
        .then((value) => setGroupAdmin(value));
  }
}
