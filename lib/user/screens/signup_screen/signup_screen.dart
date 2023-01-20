import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../common/reusable_textformfield.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var name = "";
  var email = "";
  var password = "";
  var PromoCode = "";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final PromoCodeController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    PromoCodeController.dispose();
    super.dispose();
  }
   CollectionReference users =
      FirebaseFirestore.instance.collection('users');
       registration() async {
    isLoading = true;
    setState(() {});
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      users
          .add({
            'user_Id': userCredential.user!.uid,
            'name': name,
            'email': email,
            'password': password,
            'promoCode': PromoCode
          })
          .then((value) => print("User Added"))
          .catchError(
              (error) => print('Failed to add user data in firestore: $error'));

      print(
        userCredential,
      );

      print("UserName${email}");
      Fluttertoast.showToast(msg: 'Account Created',textColor: Colors.white);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LogInScreen(),
        ),
      );
      isLoading = false;
      setState(() {});
    } on FirebaseAuthException catch (e) {
      if (password != password) {
        isLoading = false;
        setState(() {});
        print("Password Provided is not correct");
        Fluttertoast.showToast(msg: 'Password Provided is not correct',textColor: Colors.white);
        if (e.code == 'weak-password') {
          isLoading = false;
          setState(() {});
          print("Password Provided is too Weak");
          Fluttertoast.showToast(msg: 'Password Provided is too Weak',textColor: Colors.white);
        }
      } else if (e.code == 'email-already-in-use') {
        isLoading = false;
        setState(() {});
        print("Account Already exists");
        Fluttertoast.showToast(msg: 'Account Already exists',textColor: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF292b2e),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Name
                  Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Name TextField
                  ReusableTextForm(controller: nameController,
                    hintText: "Name",
                    prefixIcon: Icons.person,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //email
                  Text(
                    "E-mail",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  // Email
                  SizedBox(
                    height: 10,
                  ),
                  // Email
                  ReusableTextForm(controller: emailController,
                    hintText: "Email",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //password
                  Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  // password TextField
                  SizedBox(
                    height: 10,
                  ),
                  // password
                  ReusableTextForm(controller: passwordController,
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Promo Code",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  // password TextField
                  SizedBox(
                    height: 10,
                  ),
                  // password
                  ReusableTextForm(controller: PromoCodeController,
                    hintText: "Promo Code",
                    prefixIcon: Icons.code,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'This field is required';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Sign Up
                   isLoading
                            ? const Center(
                                child: SizedBox(
                                    width: 80,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballBeat,
                                      colors: [
                                        Color(0xff5FDED7),
                                      ],
                                      strokeWidth: 2,
                                      pathBackgroundColor: Color(0xff5FDED7),
                                    )),
                              )
                            :
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
 setState(() {
                                        PromoCode =
                                            PromoCodeController.text;
                                        email = emailController.text;
                                        name = nameController.text;
                                        password = passwordController.text;
                                      });
                                      registration();
                          // // Fluttertoast.showToast(
                          // //   msg: "Account Created",
                          // //   //backgroundColor: Colors.transparent,
                          // //   textColor: Colors.white,
                          // );
                        } else {
                          Fluttertoast.showToast(
                            msg: "All fields are required",
                            //backgroundColor: Colors.transparent,
                            textColor: Colors.white,
                          );
                        }
                      },
                      child: Text("Sign Up"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return LogInScreen();
                            }));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
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
