import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color.dart';

String? fontFamily = GoogleFonts.abhayaLibre().fontFamily;

ThemeData myTheme = ThemeData(
    primaryColor: AppColor.primary,
    appBarTheme: const AppBarTheme(backgroundColor: AppColor.primary),
    textTheme: TextTheme(
        displayLarge: TextStyle(
            color: AppColor.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        titleSmall: TextStyle(
            color: AppColor.black, fontSize: 16, fontFamily: fontFamily),
        displayMedium: TextStyle(
            color: AppColor.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        displaySmall: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        headlineLarge: TextStyle(
            color: AppColor.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        headlineMedium: TextStyle(
            color: AppColor.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        headlineSmall: TextStyle(
            color: AppColor.grey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        bodyLarge: TextStyle(
            color: AppColor.black, fontSize: 16, fontFamily: fontFamily),
        bodyMedium: TextStyle(
            color: AppColor.black, fontSize: 12, fontFamily: fontFamily),
        labelLarge: const TextStyle(
            fontWeight: FontWeight.bold, fontFamily: "Traditional")));
