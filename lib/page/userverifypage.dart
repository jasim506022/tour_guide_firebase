import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/approutes.dart';
import '../const/const.dart';
import '../const/gobalcolor.dart';
import '../service/database/firebasedatabase.dart';
import 'homepage.dart';

class UserVerifyPage extends StatefulWidget {
  const UserVerifyPage(
      {super.key,
      required this.name,
      required this.phone,
      required this.userCredential,
      required this.gender});
  final String name;
  final String phone;
  final String gender;
  final UserCredential userCredential;

  @override
  State<UserVerifyPage> createState() => _UserVerifyPageState();
}

class _UserVerifyPageState extends State<UserVerifyPage> {
  bool isEmailVerify = false;
  bool canResendEmail = false;

  Timer? timer;
  @override
  void initState() {
    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    uploadData();
    if (!isEmailVerify) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 5),
        (_) => checkEmailVerifield(),
      );
    }
    super.initState();
  }

  uploadData() async {
    await FirebaseDatabase.createUserByEmailPassword(
        gender: widget.gender,
        name: widget.name,
        phone: widget.phone,
        userCredential: widget.userCredential);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerifield() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerify) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(() {
      canResendEmail = false;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      canResendEmail = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isEmailVerify) {
      uploadData();
    }
    return isEmailVerify
        ? const HomePage()
        : Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text("A Verification  email has sent to your email",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: mq.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.width * 0.022,
                            vertical: mq.height * 0.018),
                      ),
                      icon: Icon(Icons.email, size: 32, color: white),
                      label: Text("Resent Email",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: white,
                              fontWeight: FontWeight.bold)),
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: greenColor, width: 2))),
                    child: const Text("Cencel"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRouters.signPage, (route) => false);
                      });
                    },
                  )
                ],
              ),
            ),
          );
  }
}
