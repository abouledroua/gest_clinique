import 'package:flutter/material.dart';

import '../../core/constant/theme.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool smallSize;
  final IconData icon;
  final Function()? onPressed;
  final Color backGroundcolor, frontColor;
  const MyButton(
      {super.key,
      this.onPressed,
      this.smallSize = false,
      required this.backGroundcolor,
      required this.frontColor,
      required this.icon,
      required this.text});

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          color: backGroundcolor, border: Border.all(color: frontColor)),
      child: TextButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: frontColor, size: smallSize ? 18 : 24),
          label: Text(text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: smallSize ? 12 : 16,
                  fontFamily: fontFamily,
                  color: frontColor))));
}
