import 'package:flutter/material.dart';
import 'package:lecture_app/user/screens/login_screen/login_screen.dart';

import 'admin/auth/login_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration:
              const BoxDecoration(image: DecorationImage(image: AssetImage("assets/landing.jpeg"), fit: BoxFit.cover)),
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.purple[900],
                    minWidth: 300,
                    height: 55,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                        child: Text(
                      "User",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.purple[900],
                    minWidth: 300,
                    height: 55,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                        child: Text(
                      "Admin",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
