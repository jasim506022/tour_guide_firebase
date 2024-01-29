import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
import '../mainpage.dart';

enum Gender { male, female, other }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Gender _selectGender = Gender.male;
  UserCredential? userCredential;

  @override
  void dispose() {
    _phoneET.dispose();
    _nameET.dispose();
    _emailET.dispose();
    _passwordET.dispose();
    _confirmpasswordET.dispose();
    super.dispose();
  }

  final TextEditingController _phoneET = TextEditingController();
  final TextEditingController _nameET = TextEditingController();
  final TextEditingController _emailET = TextEditingController();
  final TextEditingController _passwordET = TextEditingController();
  final TextEditingController _confirmpasswordET = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        color: white,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.width * .0444, vertical: mq.height * .024),
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
                          "Name",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        TextFieldFormWidget(
                          hintText: 'Your Name',
                          controller: _nameET,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Email Address';
                            } else if (globalMethod.isValidEmail(value) ==
                                false) {
                              return 'Please Enter a Valid Email Address';
                            }
                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
                        Text(
                          "Phone",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        TextFieldFormWidget(
                          hintText: 'Phone Number',
                          controller: _phoneET,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Email Address';
                            } else if (!(value!.length == 11)) {
                              return 'Phone Number Must Be 11 Digit';
                            }
                            return null;
                          },
                          textInputType: TextInputType.phone,
                        ),
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        TextFieldFormWidget(
                          obscureText: true,
                          isShowPassword: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                          hintText: "Password",
                          controller: _passwordET,
                        ),
                        Text(
                          "Comfirm Password",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        TextFieldFormWidget(
                          obscureText: true,
                          isShowPassword: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Confirm Password';
                            }
                            return null;
                          },
                          hintText: "Confirm Password",
                          controller: _confirmpasswordET,
                        ),
                        Row(
                          children: [
                            Text(
                              "Gender",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Radio<Gender>(
                              value: Gender.male,
                              groupValue: _selectGender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _selectGender = value!;
                                });
                              },
                            ),
                            Text(
                              "Male",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: black),
                            ),
                            Radio<Gender>(
                              value: Gender.female,
                              groupValue: _selectGender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _selectGender = value!;
                                });
                              },
                            ),
                            Text(
                              "Female",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: black),
                            ),
                            Radio<Gender>(
                              value: Gender.other,
                              groupValue: _selectGender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _selectGender = value!;
                                });
                              },
                            ),
                            Text(
                              "Other",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: black),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .018,
                  ),
                  Consumer<LoadingProvider>(
                    builder: (context, loadingProvider, child) {
                      return _buildSignUpButton(
                        loadingProvider,
                      );
                    },
                  ),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  globalMethod.buldRichText(
                      context: context,
                      simpleText: "Already Create An Account? ",
                      colorText: "Sign In",
                      function: () {
                        Navigator.pushReplacementNamed(
                            context, AppRouters.signPage);
                      }),
                  SizedBox(
                    height: mq.height * .12,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Column _signinPageIntro() {
    return Column(
      children: [
        Image.asset(
          "asset/image/logo.png",
          height: mq.height * .177,
          width: mq.height * .177,
        ),
        SizedBox(
          height: mq.height * .012,
        ),
        Text("Registration",
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
      ],
    );
  }

  Widget _buildSignUpButton(LoadingProvider loadingProvider) {
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

          if (_passwordET.text.trim() == _confirmpasswordET.text.trim()) {
            {
              showDialog(
                context: context,
                builder: (context) {
                  return const LoadingWidget(message: "Registration......");
                },
              );
              try {
                final result = await InternetAddress.lookup('google.com');

                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                  loadingProvider.setLoading(loading: true);
                  userCredential = await FirebaseDatabase
                      .createUserWithEmilandPaswordSnaphsot(
                    email: _emailET.text,
                    password: _passwordET.text,
                  ).then((value) {
                    loadingProvider.setLoading(loading: false);

                    globalMethod.flutterToast(msg: "Successfully Register");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(
                            name: _nameET.text,
                            phone: _phoneET.text,
                            gender: _selectGender.name,
                            userCredential: value!,
                          ),
                        ));
                  });
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
                loadingProvider.setLoading(loading: false);
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
                          message: e.toString(), title: 'Error Occurred');
                    },
                  );
                }

                loadingProvider.setLoading(loading: false);
              }
            }
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return const ShowErrorDialogWidget(
                    message:
                        "Password and Confirm Password Is Not Match. Please Check Password",
                    title: 'Please Check Password');
              },
            );
          }
        },
        child: loadingProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: white,
                ),
              )
            : Text(
                "Sign Up",
                style: GoogleFonts.poppins(
                    color: white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
      ),
    );
  }
}
