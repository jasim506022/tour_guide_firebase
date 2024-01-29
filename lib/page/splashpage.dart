import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/approutes.dart';
import '../const/const.dart';
import '../const/gobalcolor.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushNamed(
            context,
            FirebaseAuth.instance.currentUser == null
                ? AppRouters.signPage
                : AppRouters.homepage);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: mq.height * .071,
        ),
        Image.asset(
          "asset/image/logo.png",
          height: mq.height * .1,
          width: mq.height * .1,
        ),
        SizedBox(
          height: mq.height * .012,
        ),
        Text(
          "Tour Guide Apps",
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: black),
        ),
        SizedBox(
          height: mq.height * .059,
        ),
      ],
    ));
  }
}
