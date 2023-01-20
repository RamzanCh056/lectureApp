import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final Widget ? icon;
  const SocialIcon({
    Key? key, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFCDCED1),
        ),
      ),
      child: Center(child: icon,),
    );
  }
}