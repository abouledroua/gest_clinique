import 'package:flutter/material.dart';

import '../../core/constant/theme.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool smallSize, enabled;
  final IconData icon;
  final Function()? onPressed;
  final Color backGroundcolor, frontColor;
  const MyButton(
      {super.key,
      this.onPressed,
      this.smallSize = false,
      this.enabled = true,
      required this.backGroundcolor,
      required this.frontColor,
      required this.icon,
      required this.text});

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: enabled ? onPressed : null,
      child: Ink(
        child: Container(
            padding: EdgeInsets.all(smallSize ? 4 : 8),
            decoration: BoxDecoration(
                color: backGroundcolor, border: Border.all(color: frontColor)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(icon, color: frontColor, size: smallSize ? 18 : 24),
              const SizedBox(width: 3),
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: smallSize ? 12 : 16,
                      fontFamily: fontFamily,
                      color: frontColor))
            ])),
      ));
}
