import 'package:flutter/material.dart';

import '../../core/constant/color.dart';
import '../../core/constant/theme.dart';

class MyTextField extends StatelessWidget {
  final String hintText, labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText, enabled, upperCase;
  const MyTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      required this.enabled,
      this.upperCase = false,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) => TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: !upperCase
          ? null
          : (value) {
              controller.value = TextEditingValue(
                  text: value.toUpperCase(), selection: controller.selection);
            },
      textCapitalization:
          upperCase ? TextCapitalization.characters : TextCapitalization.none,
      obscureText: obscureText,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: AppColor.black,
          fontFamily: fontFamily),
      decoration: InputDecoration(
          alignLabelWithHint: true,
          label: Text(labelText),
          hintText: hintText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromARGB(255, 221, 240, 221),
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppColor.black,
              fontFamily: fontFamily),
          hintStyle: TextStyle(fontSize: 10, fontFamily: fontFamily)));
}
