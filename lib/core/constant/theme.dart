import 'package:flutter/material.dart';

import 'color.dart';

myTheme() => ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.blue1,
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: AppColor.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: "Traditional"),
        headlineMedium: TextStyle(
            color: AppColor.grey,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "Traditional"),
        displayMedium: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Traditional"),
        bodyLarge: TextStyle(
            color: AppColor.greyblack, fontSize: 16, fontFamily: "Traditional"),
        bodyMedium: TextStyle(
            color: AppColor.black, fontSize: 12, fontFamily: "Traditional"),
        bodySmall: TextStyle(
            color: AppColor.greyblack, fontSize: 11, fontFamily: "Traditional"),
        labelLarge:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: "Traditional")));
