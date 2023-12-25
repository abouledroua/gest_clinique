import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gest_clinique/core/constant/routes.dart';
import 'package:get/get.dart';

import '../core/constant/sizes.dart';

class RegisterDoctorController extends GetxController {
  late TextEditingController emailController, passController, nameController;
  String? selectedOrg = 'Cabinet Médical Dr Loucif';
  String? selectedFonction = 'Votre Fonction';
  bool inscr = false;

  List<String> fonctions = ['Votre Fonction', 'Docteur', 'Réception'];
  List<String> orgs = [
    'Cabinet Médical Dr Loucif',
    'Cabinet Médical Dr Diabi',
    'Cabinet Médical Dr Bekouche',
    'Cabinet Médical Dr Slougui'
  ];

  updateDropOrg(String? value) {
    selectedOrg = value;
    update();
  }

  updateDropFct(String? value) {
    selectedFonction = value;
    update();
  }

  inscrire() {
    inscr = true;
    update();
    Timer(const Duration(seconds: 3), _gotoLogin);
  }

  _gotoLogin() {
    Get.toNamed(AppRoute.login);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _initConnect();
    super.onInit();
  }

  _initConnect() {
    AppSizes.setSizeScreen(Get.context);
    inscr = false;
    nameController = TextEditingController();
    passController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
