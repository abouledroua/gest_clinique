import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

String? fontFamily = GoogleFonts.abhayaLibre().fontFamily;

myTheme() => ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.blue1,
    textTheme: TextTheme(
        displayLarge: TextStyle(
            color: AppColor.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        headlineMedium: TextStyle(
            color: AppColor.grey,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        displayMedium: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily),
        bodyLarge: TextStyle(
            color: AppColor.greyblack, fontSize: 16, fontFamily: fontFamily),
        bodyMedium: TextStyle(
            color: AppColor.black, fontSize: 12, fontFamily: fontFamily),
        bodySmall: TextStyle(
            color: AppColor.greyblack, fontSize: 11, fontFamily: fontFamily),
        labelLarge:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamily)));
