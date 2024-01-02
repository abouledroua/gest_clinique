import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/user.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';
import '../core/services/settingservice.dart';
import 'dashboard_controller.dart';
import 'rdv_controller.dart';

class LoginController extends GetxController {
  late TextEditingController emailController,
      passController,
      usernameController;
  String defaultOrg = 'Choisir votre Organisme';
  late String selectedOrg;
  List<String> orgs = [];
  List<int> orgsId = [];
  bool valider = false,
      connectEmail = true,
      conect = false,
      valUser = false,
      valEmail = false,
      loading = false,
      error = false,
      valPass = false;

  updateConnctEmail() {
    connectEmail = !connectEmail;
    update();
  }

  updateDrop(String value) {
    selectedOrg = value;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _updateValider({required bool newValider, newInscr = false}) {
    valider = newValider;
    conect = newInscr;
    update();
  }

  login() {
    valUser = passController.text.isEmpty;
    valPass = passController.text.isEmpty;
    valEmail = emailController.text.isEmpty;
    if (valPass || (valEmail && connectEmail) || (valUser && !connectEmail)) {
      AppData.mySnackBar(
          color: AppColor.red,
          title: 'Fiche Login',
          message: "Veuillez remplir les champs oligatoire !!!!");
    } else {
      if (selectedOrg == defaultOrg) {
        AppData.mySnackBar(
            color: AppColor.red,
            title: 'Fiche Login',
            message: "Veuillez choisir un organisme !!!");
      } else {
        if (connectEmail) {
          usernameController.text = "";
        } else {
          emailController.text = "";
        }
        _updateValider(newValider: true, newInscr: false);
        _existUser();
      }
    }
  }

  _existUser() async {
    int idCabinet = orgsId[orgs.indexOf(selectedOrg)];
    await existData(urlFile: "EXIST_USER_LOGIN.php", nomFiche: 'Login', body: {
      "USERNAME": usernameController.text,
      "EMAIL": emailController.text,
      "PASSWORD": passController.text,
      "ID_CABINET": idCabinet.toString(),
    }).then((value) {
      if (value.success) {
        int idUser = 0, type = 0, sexe = 0;
        String name = "", username = "", email = "";
        for (var m in value.data) {
          idUser = int.parse(m['ID_USER']);
          type = int.parse(m['TYPE']);
          sexe = int.parse(m['SEXE']);
          name = m['NAME'];
          email = m['EMAIL'];
          username = m['USERNAME'];
        }
        if (idUser == 0) {
          usernameController.text = "";
          emailController.text = "";
          passController.text = "";
          selectedOrg = orgs[0];
          _updateValider(newValider: false);
          AppData.mySnackBar(
              title: 'Fiche Utilisateur',
              message: "Coordonées invalide !!!",
              color: AppColor.red);
        } else {
          User.email = email;
          User.username = username;
          User.name = name;
          User.password = passController.text;
          User.type = type;
          User.isDoctor = (User.type == 1);
          User.isNurse = (User.type == 2);
          User.sexe = sexe;
          User.isFemme = (User.sexe == 2);
          User.isHomme = (User.type == 1);
          User.cabinet = selectedOrg;
          User.idCabinet = idCabinet;
          User.idUser = idUser;

          SettingServices c = Get.find();
          c.sharedPrefs.setString('USERNAME', usernameController.text);
          c.sharedPrefs.setString('EMAIL', emailController.text);
          c.sharedPrefs.setString('NAME', name);
          c.sharedPrefs.setString('PASSWORD', passController.text);
          c.sharedPrefs.setString('CABINET', selectedOrg);
          c.sharedPrefs.setInt('ID_CABINET', idCabinet);
          c.sharedPrefs.setInt('SEXE', sexe);
          c.sharedPrefs.setInt('TYPE', type);
          c.sharedPrefs.setInt('ID_USER', idUser);
          c.sharedPrefs.setBool('CONNECTED', true);

          _updateValider(newValider: false, newInscr: true);
          debugPrint("Utilisateur existe ...");
          Timer(const Duration(seconds: 3), _gotoDashBoard);
        }
      } else {
        _updateValider(newValider: false);
      }
    });
  }

  _gotoDashBoard() {
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
    _updateBooleans(newloading: true, newerror: false);
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

    usernameController = TextEditingController();
    passController = TextEditingController();
    emailController = TextEditingController();
    selectedOrg = defaultOrg;
  }

  @override
  void onClose() {
    emailController.dispose();
    usernameController.dispose();
    passController.dispose();
    super.onClose();
  }
}
