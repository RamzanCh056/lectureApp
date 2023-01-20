import 'package:flutter/material.dart';

import '../../../common/otp_text_field.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF292b2e),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter 4 digit Code Send to the Email",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpTextField(
                    onChanged: (v) {
                      if (v.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                  OtpTextField(
                    onChanged: (v) {
                      if (v.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                  OtpTextField(
                    onChanged: (v) {
                      if (v.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                  OtpTextField(
                    onChanged: (v) {
                      if (v.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                  },
                  child: Text("Verify"),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
