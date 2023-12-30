import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/sizes.dart';

class AcceuilController extends GetxController {
  String defaultRap = 'Ce Jours',
      defaultRapPat = 'Cette Semaine',
      defaultRapSexe = '2023';
  List<String> dropRap = [], dropRapSexe = [], dropRapPat = [];

  String? selectedRap, selectedRapSexe, selectedRapPat;

  updateDropRap(String? value) {
    selectedRap = value;
    update();
  }

  updateDropRapSexe(String? value) {
    selectedRapSexe = value;
    update();
  }

  updateDropRapPat(String? value) {
    selectedRapPat = value;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    selectedRap = defaultRap;
    dropRap = [defaultRap, 'Ce Mois', 'Cette Année', 'Tous'];

    selectedRapPat = defaultRapPat;
    dropRapPat = [defaultRapPat, 'Ce Mois', 'Cette Année', 'Tous'];

    selectedRapSexe = defaultRapSexe;
    dropRapSexe = ['2020', '2021', '2022', defaultRapSexe, 'Tous'];
  }
}
