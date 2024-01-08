import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/sizes.dart';

class AcceuilController extends GetxController {
  List<String> dropRap = [];
  String defaultRap = 'Ce Jours';
  String? selectedRap;

  updateDropRap(String? value) {
    selectedRap = value;
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
    dropRap = [defaultRap, 'Ce Mois', 'Cette Année'];
  }
}
