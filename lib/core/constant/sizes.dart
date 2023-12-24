import 'dart:math';

import 'package:flutter/material.dart';

class AppSizes {
  static const double maxWidth = 800;
  static late double appWidthScreen, widthScreen, heightScreen;

  static setSizeScreen(context) {
    widthScreen = MediaQuery.of(context).size.width;
    appWidthScreen = min(MediaQuery.of(context).size.width, maxWidth);
    heightScreen = MediaQuery.of(context).size.height;
  }
}
