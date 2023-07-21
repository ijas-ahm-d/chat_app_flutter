
import 'package:chat_app/user_auth/view_model/login_view_model.dart';
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

  // saving the userData
  Future savingUserData(BuildContext context) async {
    final provider = context.read<SignupViewModel>();
    return await userCollection.doc(uid).set({
      "fullName": provider.userNameController.text.trim(),
      "email": provider.emailController.text.trim(),
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

// getting userData
  Future gettingUserData(BuildContext context) async {
    final provider = context.read<LoginViewModel>();
    QuerySnapshot snapshot = await userCollection
        .where("email", isEqualTo: provider.emailController.text.trim())
        .get();
    return snapshot;
  }

  // get user groups
  Future getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // create a group
  Future createGroup(String userName, String id, String groupname) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupname,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
// update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupname"])
    });
  }

  // getting the chats
  Future getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  //get group admin
  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot["admin"];
  }

  // get the members
  Future getMembers(String groupID) async {
    return groupCollection.doc(groupID).snapshots();
  }

// Search
  Future search(String groupName) async {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  //check user already exist
  Future<bool> isUserJoined(
      String grpName, String grpId, String usrName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot["groups"];
    if (groups.contains("${grpId}_$grpName")) {
      return true;
    } else {
      return false;
    }
  }

  // group join
  Future groupJoin(String grpId, String usrName, String grpName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(grpId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot["groups"];
    if (groups.contains("${grpId}_$grpName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${grpId}_$grpName"])
      });
      await groupDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${uid}_$usrName"])
      });
    }else{
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${grpId}_$grpName"])
      });
      await groupDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${uid}_$usrName"])
      });
    }
  }
}
