import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/services/settingservice.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passController;
  String? selectedItem = 'Cabinet Médical Dr Loucif';
  List<String> items = [
    'Cabinet Médical Dr Loucif',
    'Cabinet Médical Dr Diabi',
    'Cabinet Médical Dr Bekouche',
    'Cabinet Médical Dr Slougui'
  ];
  bool inscr = false;

  updateDrop(String? value) {
    selectedItem = value;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _initConnect();
    super.onInit();
  }

  inscrire() {
    inscr = true;
    update();
    Timer(const Duration(seconds: 3), _gotoDashBoard);
  }

  _gotoDashBoard() {
    Get.toNamed(AppRoute.dashboard);
  }

  _initConnect() {
    AppSizes.setSizeScreen(Get.context);
    passController = TextEditingController();
    emailController = TextEditingController();
    SettingServices c = Get.find();
    String emailPref = c.sharedPrefs.getString('EMAIL') ?? "";
    String passPref = c.sharedPrefs.getString('PASSWORD') ?? "";
    String orgPref = c.sharedPrefs.getString('ORGANISATION') ?? "";
    bool connect = c.sharedPrefs.getBool('CONNECTED') ?? false;
    if (emailPref.isNotEmpty && connect) {
      emailController.text = emailPref;
      passController.text = passPref;
      selectedItem = orgPref;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }
}
