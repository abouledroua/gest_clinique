import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/user.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/services/settingservice.dart';
import 'dashboard_controller.dart';
import 'rdv_controller.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passController;
  String defaultOrg = 'Choisir votre Organisme';
  String? selectedOrg;
  List<String> orgs = [];
  bool inscr = false, conect = false;

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
      conect = true;
      update();
      Timer(const Duration(seconds: 4), _gotoConnect);
    }
  }

  _gotoConnect() {
    conect = false;
    inscr = true;
    update();
    Timer(const Duration(seconds: 3), _gotoDashBoard);
  }

  _gotoDashBoard() {
    User.email = emailController.text;
    User.name = emailController.text;
    User.password = passController.text;
    User.type = 1;
    User.isDoctor = (User.type == 1);
    User.isNurse = (User.type == 2);
    User.sexe = 1;
    User.isFemme = (User.sexe == 2);
    User.isHomme = (User.type == 1);
    User.organisation = selectedOrg!;
    User.idUser = 1;

    SettingServices c = Get.find();
    c.sharedPrefs.setString('EMAIL', emailController.text);
    c.sharedPrefs.setString('PASSWORD', passController.text);
    c.sharedPrefs.setString('ORGANISATION', selectedOrg!);
    c.sharedPrefs.setBool('CONNECTED', true);

    if (Get.isRegistered<DashBoardController>()) {
      Get.delete<DashBoardController>();
    }
    if (Get.isRegistered<RDVController>()) {
      Get.delete<RDVController>();
    }
    Get.offAllNamed(AppRoute.dashboard);
  }

  _initConnect() {
    AppSizes.setSizeScreen(Get.context);
    conect = false;
    inscr = false;
    passController = TextEditingController();
    emailController = TextEditingController();
    selectedOrg = defaultOrg;
    orgs = [
      defaultOrg,
      'Cabinet Médical Dr Loucif',
      'Cabinet Médical Dr Diabi',
      'Cabinet Médical Dr Bekouche',
      'Cabinet Médical Dr Slougui'
    ];
    SettingServices c = Get.find();
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
