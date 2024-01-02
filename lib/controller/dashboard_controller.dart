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
    SettingServices c = Get.find();
    User.email = c.sharedPrefs.getString('EMAIL') ?? "";
    User.username = c.sharedPrefs.getString('USERNAME') ?? "";
    User.name = c.sharedPrefs.getString('NAME') ?? "";
    User.password = c.sharedPrefs.getString('PASSWORD') ?? "";
    User.cabinet = c.sharedPrefs.getString('CABINET') ?? "";
    User.idCabinet = c.sharedPrefs.getInt('ID_CABINET') ?? 0;
    User.idUser = c.sharedPrefs.getInt('ID_USER') ?? 0;

    User.type = c.sharedPrefs.getInt('TYPE') ?? 0;
    User.isDoctor = (User.type == 1);
    User.isNurse = (User.type == 2);
    User.sexe = c.sharedPrefs.getInt('SEXE') ?? 0;
    User.isFemme = (User.sexe == 2);
    User.isHomme = (User.type == 1);
  }
}
