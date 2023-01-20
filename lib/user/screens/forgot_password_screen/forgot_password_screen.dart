import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lecture_app/user/screens/login_screen/login_screen.dart';

import '../../../common/reusable_textformfield.dart';
import '../otp_screen/otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var email1 = "";
  final emailController = TextEditingController();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email1);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return LogInScreen();
          },
        ),
      );
      Fluttertoast.showToast(
          msg: 'Password Reset Email has been sent !', textColor: Colors.white);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
            msg: 'No user found for that email.', textColor: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF292b2e),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "E-mail",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Email TextField
                  ReusableTextForm(
                    controller: emailController,
                    hintText: "Your Email",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Fluttertoast.showToast(
                          //   msg: "OTP send",
                          //   //backgroundColor: Colors.transparent,
                          //   textColor: Colors.white,
                          // );
                          setState(() {
                            email1 = emailController.text;
                          });
                          resetPassword();
                        } else {
                          Fluttertoast.showToast(
                            msg: "Email are required",
                            //backgroundColor: Colors.transparent,
                            textColor: Colors.white,
                          );
                        }
                      },
                      child: Text("Send OTP"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
