import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';

class RegisterCabinetController extends GetxController {
  late TextEditingController emailController,
      telController,
      nameController,
      adrController;
  String defaultWilaya = 'Choisir votre Wilaya';
  List<String> wilayas = [];

  String? selectedWilaya;
  bool inscr = false;

  updateDropWilaya(String? value) {
    selectedWilaya = value;
    update();
  }

  inscrire() {
    if (selectedWilaya == defaultWilaya) {
      AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.error,
              showCloseIcon: true,
              title: 'Erreur',
              btnOkText: "Ok",
              width: min(AppSizes.widthScreen, 400),
              btnOkOnPress: () {},
              desc: 'Veuillez choisir la wilaya !!!')
          .show();
    } else {
      inscr = true;
      update();
      Timer(const Duration(seconds: 3), _gotoLogin);
    }
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
    selectedWilaya = defaultWilaya;
    wilayas = [
      defaultWilaya,
      'Adrar',
      'Chlef',
      'Laghouat',
      'Oum El Bouaghi',
      'Batna',
      'Bejaïa',
      'Biskra',
      'Béchar',
      'Blida',
      'Bouira',
      'Tamanrasset',
      'Tébessa',
      'Tlemcen',
      'Tiaret',
      'Tizi Ouzou',
      'Alger',
      'Djelfa',
      'Jijel',
      'Sétif',
      'Saïda',
      'Skikda',
      'Sidi Bel Abbés',
      'Annaba',
      'Guelma',
      'Constantine',
      'Médéa',
      'Mostaganem',
      "M'Sila",
      'Mascara',
      'Ouargla',
      'Oran',
      'Bayadh',
      'Illizi',
      'Bordj Bou Arreridj',
      'Boumerdés',
      'El Taref',
      'Tindouf',
      'Tissemsilt',
      'Oued',
      'Khenchela',
      'Souk Ahras',
      'Tipaza',
      'Mila',
      'Aïn Defla',
      'Naâma',
      'Aïn Témouchent',
      'Ghardaïa',
      'Relizane',
      'Timimoune',
      'Bordj Badji Mokhtar',
      'Ouled Djellal',
      'Béni Abbés',
      'In Salah',
      'In Guezzam',
      'Touggourt',
      'Djanet',
      "M'Ghair",
      'Meniaa'
    ];

    nameController = TextEditingController();
    adrController = TextEditingController();
    telController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    adrController.dispose();
    telController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
