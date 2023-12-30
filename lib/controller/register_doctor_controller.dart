import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';

class RegisterUserController extends GetxController {
  late TextEditingController emailController, passController, nameController;
  String defaultOrg = 'Choisir votre Organisme',
      defaultFct = 'Votre Fonction',
      defaultSexe = 'Votre Sexe';
  List<String> orgs = [], fonctions = [], sexes = [];

  String? selectedOrg, selectedFonction, selectedSexe;
  bool inscr = false;

  updateDropOrg(String? value) {
    selectedOrg = value;
    update();
  }

  updateDropSexe(String? value) {
    selectedSexe = value;
    update();
  }

  updateDropFct(String? value) {
    selectedFonction = value;
    update();
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
      if (selectedFonction == defaultFct) {
        AwesomeDialog(
                context: Get.context!,
                dialogType: DialogType.error,
                showCloseIcon: true,
                title: 'Erreur',
                btnOkText: "Ok",
                width: min(AppSizes.widthScreen, 400),
                btnOkOnPress: () {},
                desc:
                    'Veuillez choisir votre fonction aux sein de cet organisme !!!')
            .show();
      } else {
        inscr = true;
        update();
        Timer(const Duration(seconds: 3), _gotoLogin);
      }
    }
  }

  _gotoLogin() {
    Get.toNamed(AppRoute.login);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    inscr = false;
    selectedOrg = defaultOrg;
    selectedFonction = defaultFct;
    selectedSexe = defaultSexe;
    fonctions = [defaultFct, 'Docteur', 'Réception'];
    orgs = [
      defaultOrg,
      'Cabinet Médical Dr Loucif',
      'Cabinet Médical Dr Diabi',
      'Cabinet Médical Dr Bekouche',
      'Cabinet Médical Dr Slougui'
    ];
    sexes = [defaultSexe, 'Homme', 'Femme'];

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
