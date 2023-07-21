
import 'package:chat_app/data/network/database_service.dart';
import 'package:chat_app/user_auth/components/common_snackbar.dart';
import 'package:chat_app/user_auth/view_model/logged_view_model.dart';
import 'package:chat_app/utils/global_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

User? user;

class SearchViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  QuerySnapshot? _groups;
  QuerySnapshot? get groups => _groups;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isJoined = false;
  bool get isJoined => _isJoined;

  bool _isUserSearched = false;
  bool get isUserSearched => _isUserSearched;

  List _result = [];
  List get result => _result;

  checkLoading() {
    searchController.text.isEmpty ? setLoading(false) : setLoading(true);
  }

  setuserSearched(bool data) {
    _isUserSearched = data;
    notifyListeners();
  }

  setJoined(bool data) {
    _isJoined = data;
    notifyListeners();
  }

  setLoading(bool data) {
    _isLoading = data;
    notifyListeners();
  }

  setSearchResults(QuerySnapshot? data) {
    _groups = data;
    notifyListeners();
  }

  clearController() {
    searchController.clear();
  }

  getSearchResult() {
    // setuserSearched(true);
    setLoading(true);
    DatabaseService().search(searchController.text.trim()).then((value) {
      setLoading(false);
      setuserSearched(true);
      return setSearchResults(value);
    });
  }

  joinedOrNot(String usrName, String grpId, String grpName,
      BuildContext context) async {
    final pro = context.watch<LoggedInViewModel>();
    try {
     
        await DatabaseService(uid: pro.userID)
            .isUserJoined(grpName, grpId, usrName)
            .then((value) => setJoined(value));
     
    
      
    } on FirebaseAuthException catch (e) {
     
      return CommonSnackBAr.snackBar(
        context: context,
        data: e.message.toString(),
        color: AppColors.warn,
      );
    }
    // User? user;
    // final id = user!.uid;
  }
}
