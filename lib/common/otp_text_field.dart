import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextField extends StatelessWidget {
  final Function(String v) ? onChanged;


  const OtpTextField({
    Key? key, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 60,
      child: TextField(
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.white,
                  width: 2
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.white,
                  width: 2
                )
            ),
        ),
      ),
    );
  }
}