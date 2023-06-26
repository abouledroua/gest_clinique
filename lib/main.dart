// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constant/routes.dart';
import 'core/theme/mytheme.dart';

late SharedPreferences sharedPrefs;
final bool isMobilePlatform =
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);
final bool isAndoidMobile =
    (defaultTargetPlatform == TargetPlatform.android && !kIsWeb);
const bool testMode = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  if (isMobilePlatform) {
    if (kDebugMode || testMode) {
      print("i'm in the Mobile Platform");
    }
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  } else {
    if (kDebugMode || testMode) {
      print("i'm not in Mobile platform");
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion Clinique',
      initialRoute: loginRoute,
      routes: routes,
      theme: myTheme);
}
