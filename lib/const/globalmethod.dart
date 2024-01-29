import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service/provider/loadingprovider.dart';
import '../widget/show_error_dialog_widget.dart';
import 'gobalcolor.dart';

class GlobalMethod{

  // Email Valid
  bool isValidEmail(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  // Flutter Toast
  flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: greenColor,
        textColor: white,
        fontSize: 16.0);
  }

  void handleError(
      BuildContext context,
      dynamic e,
      LoadingProvider loadingProvider,
      ) {
    Navigator.pop(context);

    String title;
    String message;

    switch (e.code) {
      case 'email-already-in-use':
        title = 'Email Already in Use';
        message = 'Email Already In User. Please Use Another Email';
        break;
      case 'invalid-email':
        title = 'Invalid Email Address';
        message = 'Invalid Email address. Please put Valid Email Address';
        break;
      case 'weak-password':
        title = 'Invalid Password';
        message = 'Invalid Password. Please Put Valid Password';
        break;
      case 'too-many-requests':
        title = 'Too Many Requests';
        message = 'Too many requests';
        break;
      case 'operation-not-allowed':
        title = 'Operation Not Allowed';
        message = 'Operation Not Allowed';
        break;
      case 'user-disabled':
        title = 'User Disabled';
        message = 'User Disable';
        break;
      case 'user-not-found':
        title = 'User Not Found';
        message = 'User Not Found';
        break;
      case 'wrong-password':
        title = 'Incorrect password';
        message = 'Password Incorrect. Please Check your Password';
        break;
      default:
        title = 'Error Occurred';
        message = 'Please check your internet connection or other issues.';
        break;
    }

    showDialog(
      context: context,
      builder: (context) =>
          ShowErrorDialogWidget(title: title, message: message),
    );

    loadingProvider.setLoading(loading: false);
  }

  // Rich Text
  RichText buldRichText(
      {required BuildContext context,
        required String simpleText,
        required String colorText,
        required Function function}) {
    return RichText(
        text: TextSpan(children: [
          TextSpan(
            text: simpleText,
            style: GoogleFonts.poppins(
                color: cardColor, fontWeight: FontWeight.w500),
          ),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  function();
                },
              text: colorText,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                  color: deepGreen,
                  fontWeight: FontWeight.w800))
        ]));
  }
}