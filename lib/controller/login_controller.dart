import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/services/settingservice.dart';
import 'dashboard_controller.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passController;
  String defaultOrg = 'Choisir votre Organisme';
  String? selectedOrg;
  List<String> orgs = [];
  bool inscr = false;

  updateDrop(String? value) {
    selectedOrg = value;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _initConnect();
    super.onInit();
  }

  inscrire() {
    if (selectedOrg == defaultOrg) {
      AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.error,
              showCloseIcon: true,
              title: 'Erreur',
              btnOkText: "Ok",
              width: min(AppSizes.widthScreen, 400),
              btnOkOnPress: () {},
              desc: 'Veuillez choisir un organisme !!!')
          .show();
    } else {
      inscr = true;
      update();
      Timer(const Duration(seconds: 3), _gotoDashBoard);
    }
  }

  _gotoDashBoard() {
    if (Get.isRegistered<DashBoardController>()) {
      Get.delete<DashBoardController>();
    }
    Get.offAllNamed(AppRoute.dashboard);
  }

  _initConnect() {
    AppSizes.setSizeScreen(Get.context);
    passController = TextEditingController();
    emailController = TextEditingController();
    SettingServices c = Get.find();
    selectedOrg = defaultOrg;
    orgs = [
      defaultOrg,
      'Cabinet Médical Dr Loucif',
      'Cabinet Médical Dr Diabi',
      'Cabinet Médical Dr Bekouche',
      'Cabinet Médical Dr Slougui'
    ];
    String emailPref = c.sharedPrefs.getString('EMAIL') ?? "";
    String passPref = c.sharedPrefs.getString('PASSWORD') ?? "";
    String orgPref = c.sharedPrefs.getString('ORGANISATION') ?? "";
    bool connect = c.sharedPrefs.getBool('CONNECTED') ?? false;
    if (emailPref.isNotEmpty && connect) {
      emailController.text = emailPref;
      passController.text = passPref;
      selectedOrg = orgPref;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }
}
