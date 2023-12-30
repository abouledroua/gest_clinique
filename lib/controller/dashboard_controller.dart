import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/user.dart';
import '../core/constant/sizes.dart';
import '../core/services/settingservice.dart';

class DashBoardController extends GetxController {
  bool showListRdv = true, showMenu = false, logout = false;
  int indexPage = 1;

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  updateIndexPage({required int index}) {
    indexPage = index;
    update();
  }

  updateLogout({required bool value}) {
    logout = value;
    update();
  }

  updateShowListeRDv() {
    showListRdv = !showListRdv;
    update();
  }

  updateShowMenu() {
    showMenu = !showMenu;
    update();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    showListRdv = true;
    showMenu = true;
    _loadUserData();
  }

  _loadUserData() {
    User.type = 1;
    User.isDoctor = (User.type == 1);
    User.isNurse = (User.type == 2);
    User.sexe = 1;
    User.isFemme = (User.sexe == 2);
    User.isHomme = (User.type == 1);

    SettingServices c = Get.find();
    User.email = c.sharedPrefs.getString('EMAIL') ?? "";
    User.name = (User.type == 1) ? 'Dr Nom Medecin' : "Nom de l'assistante";
    User.password = c.sharedPrefs.getString('PASSWORD') ?? "";
    User.organisation = c.sharedPrefs.getString('ORGANISATION') ?? "";
    User.idUser = 1;
  }
}
