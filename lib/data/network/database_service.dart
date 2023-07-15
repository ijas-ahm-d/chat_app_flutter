import 'package:chat_app/user_auth/view_model/signup_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // updating the userData
  Future updateUserData(BuildContext context) async {
    final provider = context.read<SignupViewModel>();
    return await userCollection.doc(uid).set({
      "fullName": provider.userNameController.text.trim(),
      "email": provider.emailController.text.trim(),
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }
}