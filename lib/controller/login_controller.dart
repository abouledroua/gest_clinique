import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/user.dart';
import '../core/constant/data.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';
import '../core/services/settingservice.dart';
import 'dashboard_controller.dart';
import 'rdv_controller.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passController;
  String defaultOrg = 'Choisir votre Organisme';
  String? selectedOrg;
  List<String> orgs = [];
  List<int> orgsId = [];
  bool inscr = false, conect = false, loading = false, error = false;

  updateDrop(String? value) {
    selectedOrg = value;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
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
      conect = true;
      update();
      Timer(const Duration(seconds: 4), _gotoConnect);
    }
  }

  _gotoConnect() {
    conect = false;
    inscr = true;
    update();
    Timer(const Duration(seconds: 3), _gotoDashBoard);
  }

  _gotoDashBoard() {
    User.email = emailController.text;
    User.name = emailController.text;
    User.password = passController.text;
    User.type = 1;
    User.isDoctor = (User.type == 1);
    User.isNurse = (User.type == 2);
    User.sexe = 1;
    User.isFemme = (User.sexe == 2);
    User.isHomme = (User.type == 1);
    User.organisation = selectedOrg!;
    User.idUser = 1;

    SettingServices c = Get.find();
    c.sharedPrefs.setString('EMAIL', emailController.text);
    c.sharedPrefs.setString('PASSWORD', passController.text);
    c.sharedPrefs.setString('ORGANISATION', selectedOrg!);
    c.sharedPrefs.setBool('CONNECTED', true);

    if (Get.isRegistered<DashBoardController>()) {
      Get.delete<DashBoardController>();
    }
    if (Get.isRegistered<RDVController>()) {
      Get.delete<RDVController>();
    }
    Get.offAllNamed(AppRoute.dashboard);
  }

  _updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  getOrganismes() async {
    await getDataList(urlFile: "GET_CABINETS.php", nomFiche: "Organisation")
        .then((data) {
      if (data.success) {
        orgs = [defaultOrg];
        orgsId = [0];
        String s;
        var responsebody = data.data;
        for (var m in responsebody) {
          s = m['DESIGNATION'] +
              ' (' +
              AppData.getWilayaName(indexWilaya: int.parse(m['WILAYA']) - 1) +
              ')';
          orgs.add(s);
          orgsId.add(int.parse(m['ID_CABINET']));
        }
        _updateBooleans(newloading: false, newerror: false);
      } else {
        _updateBooleans(newloading: false, newerror: true);
      }
    });
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    getOrganismes();
    conect = false;
    inscr = false;
    passController = TextEditingController();
    emailController = TextEditingController();
    selectedOrg = defaultOrg;

    SettingServices c = Get.find();
    String emailPref = c.sharedPrefs.getString('EMAIL') ?? "";
    String passPref = c.sharedPrefs.getString('PASSWORD') ?? "";
    String orgPref = c.sharedPrefs.getString('ORGANISATION') ?? "";
    bool connect = c.sharedPrefs.getBool('CONNECTED') ?? false;
    if (emailPref.isNotEmpty && connect) {
      emailController.text = emailPref;
      passController.text = passPref;
      selectedOrg = orgPref;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }
}
