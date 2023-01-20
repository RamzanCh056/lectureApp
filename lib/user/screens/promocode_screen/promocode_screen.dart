import 'package:flutter/material.dart';
import 'package:lecture_app/common/reusable_textformfield.dart';


class PromoCode extends StatelessWidget {
  const PromoCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF292b2e),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Promo Code",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              ReusableTextForm(
                hintText: 'generate Promo Code',
                prefixIcon: Icons.code,
              ),
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Generate"),
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}
