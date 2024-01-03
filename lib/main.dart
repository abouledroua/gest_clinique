import 'dart:async';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/constant/data.dart';
import 'core/constant/routes.dart';
import 'core/constant/theme.dart';
import 'core/services/settingservice.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialApp();
  runApp(const MyApp());
}

Future initialApp() async {
  await Get.putAsync(() => SettingServices().init());
  if (AppData.isAndroidAppMobile) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  AppData.storageLocation = (kIsWeb)
      ? "/assets/db"
      : ((await getApplicationDocumentsDirectory()).path);
  await FastCachedImageConfig.init(
      subDir: AppData.storageLocation,
      clearCacheAfter: const Duration(days: 15));
}

NumberFormat formatter =
    NumberFormat.decimalPatternDigits(locale: 'fr_fr', decimalDigits: 0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion Cabinet Médical',
      routes: routes,
      initialRoute: AppRoute.login,
      theme: myTheme());
}
