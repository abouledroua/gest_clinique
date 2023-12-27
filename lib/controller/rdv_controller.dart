import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/sizes.dart';

class RDVController extends GetxController {
  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
  }
}
