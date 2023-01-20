import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lecture_app/res/static_info.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../common/custom_textfield.dart';
import '../screens/admin_page.dart';

class LoginScreen extends StatefulWidget {
  bool isFromBiometricPage;

  LoginScreen({this.isFromBiometricPage = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool showPass = true;
  bool isLoading = false;

  userLogin() async {
    isLoading = true;
    setState(() {});
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await FirebaseFirestore.instance
          .collection(StaticInfo.admin)
          .where('email', isEqualTo: userName.text)
          .get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult = await FirebaseFirestore.instance
            .collection(StaticInfo.admin)
            .where('password', isEqualTo: password.text.toLowerCase())
            .get();
        passwordExists = authResult.docs.isNotEmpty;
        if (passwordExists) {
          // await preferences.setBool('isLoggedIn', true);
          // await preferences.setString('userName', userName.text.trim());
          // await preferences.setString('password', password.text.trim());
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Successfully logged in');
          //NavigateToHome
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminSide()),
          );
        } else {
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Incorrect username or password');
        }
      } else {
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Incorrect username or password');
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }

  @override
  void initState() {
    if (widget.isFromBiometricPage) {
      // SharedPreferences.getInstance().then((value) {
      //   userName.text = value.getString('userName') ?? '';
      //   setState(() {});
      // });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 14,
                ),
                CommonTextFieldWithTitle(
                    'Email', 'Enter Email', userName, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                const SizedBox(
                  height: 14,
                ),
                CommonTextFieldWithTitle('Password', 'Enter Password', password,
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: const Icon(Icons.remove_red_eye)),
                    obscure: showPass,
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    }),
                const SizedBox(
                  height: 22,
                ),
                isLoading
                    ? Center(
                  child: SizedBox(
                      width: 80,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballBeat,
                          colors: [
                            Theme.of(context).primaryColor,
                          ],
                          strokeWidth: 2,
                          pathBackgroundColor:
                          Theme.of(context).primaryColor)),
                )
                    : buttonWidget(),
              ],
            ),
          ),
        ));
  }

  Widget buttonWidget() {
    return ButtonTheme(
      height: 47,
      minWidth: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            userLogin();
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
