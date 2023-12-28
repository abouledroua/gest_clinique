import 'package:flutter/material.dart';
import 'package:gest_clinique/core/class/user.dart';
import 'package:get/get.dart';

import '../core/constant/sizes.dart';

class DashBoardController extends GetxController {
  bool showListRdv = true;

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  updateShowListeRDv() {
    showListRdv = !showListRdv;
    update();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    showListRdv = true;
    User.email = 'email@gmail.com';
    User.name = 'the full name';
    User.password = 'password';
    User.type = 1;
    User.isDoctor = (User.type == 1);
    User.isNurse = (User.type == 2);
    User.organisation = 'Nom du cabinet medical';
    User.idUser = 1;
  }
}
