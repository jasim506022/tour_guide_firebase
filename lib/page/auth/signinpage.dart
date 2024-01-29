import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/approutes.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/loadingprovider.dart';
import '../../widget/loadingwidget.dart';
import '../../widget/show_error_dialog_widget.dart';
import '../../widget/textfieldformwidget.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _passwordET = TextEditingController();
  final TextEditingController _emailET = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordET.dispose();
    _emailET.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: white, statusBarIconBrightness: Brightness.dark));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        color: white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * .044, vertical: mq.width * .024),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _signinPageIntro(),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      TextFieldFormWidget(
                        hintText: 'Email Address',
                        controller: _emailET,
                        validator: (emailText) {
                          if (emailText!.isEmpty) {
                            return 'Please enter your Email Address';
                          } else if (!globalMethod.isValidEmail(emailText)) {
                            return 'Please Enter a Valid Email Address';
                          }
                          return null;
                        },
                        textInputType: TextInputType.emailAddress,
                      ),
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      TextFieldFormWidget(
                        isShowPassword: true,
                        obscureText: true,
                        validator: (passwordText) {
                          if (passwordText!.isEmpty) {
                            return 'Please enter your Password';
                          } else if (passwordText.length < 6) {
                            return 'password should be alphanumeric and greater than 6 character';
                          }
                          return null;
                        },
                        hintText: "Password",
                        controller: _passwordET,
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRouters.forgetPasswordPage);
                      },
                      child: Text(
                        "Forget Password",
                        style: GoogleFonts.poppins(
                            color: hintLightColor, fontWeight: FontWeight.w700),
                      ),
                    )),
                SizedBox(height: mq.height * .02),
                Consumer<LoadingProvider>(
                  builder: (context, loadingProivder, child) {
                    return _singinButton(loadingProivder);
                  },
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                _buildWithOr(),
                SizedBox(
                  height: mq.height * .024,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _signWithOtherWay(
                          function: () {
                            // User For Facebook . I already use in User
                          },
                          color: facebookColor,
                          image: "asset/icons/facebook.png",
                          title: "Facebook"),
                    ),
                    SizedBox(
                      width: mq.width * .0444,
                    ),
                    Expanded(
                      child: _signWithOtherWay(
                          function: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const LoadingWidget(
                                    message: "Loading for sign with Gmail");
                              },
                            );

                            FirebaseDatabase.signWithGoogle(context: context)
                                .then((userCredentialGmail) async {
                              Navigator.pop(context);
                              if (userCredentialGmail != null) {
                                if (await FirebaseDatabase.userExists()) {
                                  if (mounted) {
                                    Navigator.pushReplacementNamed(
                                        context, AppRouters.mainPage);
                                  }
                                } else {
                                  await FirebaseDatabase.createUserGmail()
                                      .then((value) {
                                    globalMethod.flutterToast(
                                        msg: "Successfully Login");
                                    Navigator.pushReplacementNamed(
                                        context, AppRouters.mainPage);
                                  });
                                }
                              }
                            });
                          },
                          color: red,
                          image: "asset/icons/gmail.png",
                          title: "Gmail"),
                    ),
                  ],
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                globalMethod.buldRichText(
                  colorText: "Create Account",
                  context: context,
                  function: () {
                    Navigator.pushNamed(context, AppRouters.signupPage);
                  },
                  simpleText: "Don't Have An Account? ",
                ),
                SizedBox(
                  height: mq.height * .12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _signinPageIntro() {
    return Column(
      children: [
        SizedBox(
          height: mq.height * .071,
        ),
        Image.asset(
          "asset/image/logo.png",
          height: mq.height * .177,
          width: mq.height * .177,
        ),
        SizedBox(
          height: mq.height * .012,
        ),
        Text("Welcome Back!",
            style: GoogleFonts.poppins(
                fontSize: 24, color: black, fontWeight: FontWeight.bold)),
        SizedBox(
          height: mq.height * .012,
        ),
        Text(
          "Tour Guide Apps",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: black),
        ),
        SizedBox(
          height: mq.height * .059,
        ),
      ],
    );
  }

  InkWell _signWithOtherWay(
      {required Function function,
      required Color color,
      required String image,
      required String title}) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        height: mq.height * 0.071,
        width: mq.width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: mq.height * .041,
                width: mq.height * .041,
                color: white,
              ),
              SizedBox(
                width: mq.width * .033,
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildWithOr() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: mq.height * .003,
          width: mq.width * .156,
          color: grey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * .033),
          child: Text(
            "with Or",
            style: TextStyle(color: grey),
          ),
        ),
        Container(
          height: mq.height * .003,
          width: mq.width * .156,
          color: grey,
        ),
      ],
    );
  }

  Widget _singinButton(LoadingProvider loadingProvider) {
    return SizedBox(
      width: mq.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * 0.022, vertical: mq.height * 0.018),
        ),
        onPressed: () async {
          if (!_formKey.currentState!.validate()) return;
          showDialog(
            context: context,
            builder: (context) {
              return const LoadingWidget(message: "Login......");
            },
          );
          try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              loadingProvider.setLoading(loading: true);

              await FirebaseDatabase.singEmailandPasswordSnapshot(
                email: _emailET.text,
                password: _passwordET.text,
              ).then((userCredential) {
                loadingProvider.setLoading(loading: false);
              });
              Navigator.pushNamed(context, AppRouters.homepage);
              globalMethod.flutterToast(msg: "Sign in Successfully");
            } else {
              globalMethod.flutterToast(msg: "No Internet Connection");
            }
          } on SocketException {
            if (mounted) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return const ShowErrorDialogWidget(
                    message:
                        "No Internet Connection. Please your Internet Connection",
                    title: 'No Internet Connection',
                  );
                },
              );
            }
          } on FirebaseAuthException catch (e) {
            if (mounted) {
              globalMethod.handleError(context, e, loadingProvider);
            }
          } catch (e) {
            if (mounted) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return ShowErrorDialogWidget(
                    message: e.toString(),
                    title: 'Error Occurred',
                  );
                },
              );
            }

            loadingProvider.setLoading(loading: false);
          }
        },
        child: loadingProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: white,
                ),
              )
            : Text(
                "Sign In",
                style: GoogleFonts.poppins(
                    color: white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
      ),
    );
  }
}
