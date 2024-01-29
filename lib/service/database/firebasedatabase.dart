import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../const/const.dart';
import '../../model/profilemodel.dart';
import '../../widget/show_error_dialog_widget.dart';

class FirebaseDatabase {
  // instance of FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;
  // instance of FirebaseFirestore
  static final firestore = FirebaseFirestore.instance;

  // create User With Email and Password Snapshot
  static Future<UserCredential> createUserWithEmilandPaswordSnaphsot(
      {required String email, required String password}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  // Create User and Post Data Firebase
  static Future<void> createUserGmail() async {
    // ProfileModel profileModel = ProfileModel(
    //     name: user.displayName,
    //     earnings: 0.0,
    //     status: "approved",
    //     email: user.email,
    //     phone: user.phoneNumber,
    //     uid: user.uid,
    //     address: "",
    //     imageurl: user.photoURL);
    //
    // firestore.collection("seller").doc(user.uid).set(profileModel.toMap());
  }

  // Create User and Post Data Firebase
  static Future<void> createUserByEmailPassword({
    required UserCredential userCredential,
    required String phone,
    required String name,
    required String gender,
    // required String image
  }) async {
    ProfileModel profileModel = ProfileModel(
      name: name,
      gender: gender,
      status: "approved",
      email: userCredential.user!.email,
      phone: phone,
      uid: userCredential.user!.uid,
    );

    firestore
        .collection("user")
        .doc(userCredential.user!.uid)
        .set(profileModel.toMap());
  }

  //Sign in With Email and Passwords
  static Future<UserCredential> singEmailandPasswordSnapshot(
      {required String email, required String password}) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // user is Exist on Database
  static Future<bool> userExists() async =>
      (await firestore.collection("seller").doc(auth.currentUser!.uid).get())
          .exists;

  // Sign In With Gmail
  static Future<UserCredential?> signWithGoogle(
      {required BuildContext context}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        return await auth.signInWithCredential(credential);
      } else {
        globalMethod.flutterToast(msg: "No Internet Connection");
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return ShowErrorDialogWidget(
              message: "Error Ocured: $e", title: 'Error Occured');
        },
      );
      return null;
    }
    return null;
  }
}
