import 'package:flutter/material.dart';

class ReusableTextForm extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool? obscureText;
  final bool? enabled;
  final Widget? suffixIcon;
  final IconData? prefixIcon;

  const ReusableTextForm({
    Key? key,
    this.validator,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        hintColor: Colors.white,
        textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.white)
      ),
      child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText!,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: Icon(prefixIcon,color: Colors.white,),
            enabled: enabled!,
            hintText: hintText,


            contentPadding: const EdgeInsets.only(left: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 2)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 2)),
          ),
          // validations
          validator: validator),
    );
  }
}
