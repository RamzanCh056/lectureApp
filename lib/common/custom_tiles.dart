// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Icon? icon;
  final String? title;
  final Icon? trailing;
  final VoidCallback? onTap;
  const CustomTile({Key? key, this.icon, this.title, this.onTap, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            icon!,
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
                  title!,
                  style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
                )),
            trailing!
          ],
        ),
      ),
    );
  }
}
