import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/sizes.dart';
import 'patient_controller.dart';

class ListPatientController extends GetxController {
  late TextEditingController queryController;

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    queryController = TextEditingController();
    if (!Get.isRegistered<PatientController>()) {
      Get.put(PatientController());
    }
  }

  @override
  void onClose() {
    queryController.dispose();
    super.onClose();
  }
}
