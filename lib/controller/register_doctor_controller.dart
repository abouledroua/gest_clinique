import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';

class RegisterUserController extends GetxController {
  late TextEditingController emailController, passController, nameController;
  String defaultOrg = 'Choisir votre Organisme',
      defaultFct = 'Votre Fonction',
      defaultSexe = 'Votre Sexe';
  List<String> orgs = [], fonctions = [], sexes = [];
  late String selectedOrg, selectedFonction, selectedSexe;
  bool loading = false,
      valDes = false,
      valEmail = false,
      valider = false,
      error = false,
      inscr = false;

  _updateValider({required bool newValue}) {
    valider = newValue;
    update();
  }

  saveClasse() {
    inscr = false;
    _updateValider(newValue: true);
    valDes = nameController.text.isEmpty;
    valEmail = emailController.text.isEmpty;
    if (valDes || valEmail) {
      debugPrint("Veuillez saisir les champs obligatoires !!!!");
      _updateValider(newValue: false);
      AppData.mySnackBar(
          color: AppColor.red,
          title: 'Fiche Docteur / Assistante',
          message: "Veuillez remplir les champs oligatoire !!!!");
    } else {
      if (selectedOrg == defaultOrg) {
        AppData.mySnackBar(
            color: AppColor.red,
            title: 'Fiche Docteur / Assistante',
            message: "Veuillez choisir un organisme !!!");
      } else {
        if (selectedFonction == defaultFct) {
          AppData.mySnackBar(
              color: AppColor.red,
              title: 'Fiche Docteur / Assistante',
              message:
                  "Veuillez choisir votre fonction aux sein de cet organisme !!!");
        } else {
          _existClasse();
        }
      }
    }
  }

  _existClasse() async {
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/EXIST_CABINET.php";
    debugPrint(url);
    Uri myUri = Uri.parse(url);
    http
        .post(myUri, body: {
          "DESIGNATION": nameController.text,
          "ID_CABINET": idCabinet.toString()
        })
        .timeout(AppData.getTimeOut())
        .then((response) async {
          if (response.statusCode == 200) {
            var responsebody = jsonDecode(response.body);
            int result = 0;
            for (var m in responsebody) {
              result = int.parse(m['ID_CABINET']);
            }
            if (result == 0) {
              debugPrint("Docteur / Assistante n'existe pas ...");
              if (idCabinet == 0) {
                _insertClasse();
              } else {
                _updateClasse();
              }
            } else {
              _updateValider(newValue: false);
              AppData.mySnackBar(
                  title: 'Fiche Docteur / Assistante',
                  message: "Ce Docteur / Assistante existe déjà !!!",
                  color: AppColor.red);
            }
          } else {
            _updateValider(newValue: false);
            AppData.mySnackBar(
                title: 'Fiche Docteur / Assistante',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          }
        })
        .catchError((error) {
          debugPrint("erreur _existClasse: $error");
          _updateValider(newValue: false);
          AppData.mySnackBar(
              title: 'Fiche Docteur / Assistante',
              message: "Probleme de Connexion avec le serveur !!!",
              color: AppColor.red);
        });
  }

  _insertClasse() async {
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/INSERT_CABINET.php";
    debugPrint(url);
    Uri myUri = Uri.parse(url);
    int wilaya = (wilayas.indexOf(selectedWilaya) + 1);
    http.post(myUri, body: {
      "DESIGNATION": nameController.text,
      "EMAIL": emailController.text,
      "TEL": telController.text,
      "WILAYA": wilaya.toString(),
      "ADRESSE": adrController.text
    }).then((response) async {
      if (response.statusCode == 200) {
        var responsebody = response.body;
        debugPrint("Docteur / Assistante Response=$responsebody");
        if (responsebody != "0") {
          // Get.back(result: "success");
          _updateValider(newValue: false);
          inscr = true;
          update();
          Timer(const Duration(seconds: 3), _gotoLogin);
        } else {
          _updateValider(newValue: false);
          AppData.mySnackBar(
              title: 'Fiche Docteur / Assistante',
              message: "Probleme lors de l'ajout !!!",
              color: AppColor.red);
        }
      } else {
        _updateValider(newValue: false);
        AppData.mySnackBar(
            title: 'Fiche Docteur / Assistante',
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red);
      }
    }).catchError((error) {
      debugPrint("erreur insertClasse: $error");
      _updateValider(newValue: false);
      AppData.mySnackBar(
          title: 'Fiche Docteur / Assistante',
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red);
    });
  }

  _updateClasse() async {
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/UPDATE_CABINET.php";
    debugPrint(url);
    Uri myUri = Uri.parse(url);
    http.post(myUri, body: {
      "ID_CABINET": idCabinet.toString(),
      "DESIGNATION": nameController.text,
      "EMAIL": emailController.text,
      "TEL": telController.text,
      "WILAYA": wilayas.indexOf(selectedWilaya) + 1,
      "ADRESSE": adrController.text
    }).then((response) async {
      if (response.statusCode == 200) {
        var responsebody = response.body;
        debugPrint("Docteur / Assistante Response = $responsebody");
        if (responsebody != "0") {
          // Get.back(result: "success");
          _updateValider(newValue: false);
          inscr = true;
          update();
          Timer(const Duration(seconds: 3), _gotoLogin);
        } else {
          _updateValider(newValue: false);
          AppData.mySnackBar(
              title: 'Fiche Docteur / Assistante',
              message: "Probleme lors de la mise a jour des informations !!!",
              color: AppColor.red);
        }
      } else {
        _updateValider(newValue: false);
        AppData.mySnackBar(
            title: 'Fiche Docteur / Assistante',
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red);
      }
    }).catchError((error) {
      debugPrint("erreur updateClasse: $error");
      _updateValider(newValue: false);
      AppData.mySnackBar(
          title: 'Fiche Docteur / Assistante',
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red);
    });
  }

  updateDropOrg(String value) {
    selectedOrg = value;
    update();
  }

  updateDropSexe(String value) {
    selectedSexe = value;
    update();
  }

  updateDropFct(String value) {
    selectedFonction = value;
    update();
  }

  _gotoLogin() {
    Get.toNamed(AppRoute.login);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    inscr = false;
    selectedOrg = defaultOrg;
    selectedFonction = defaultFct;
    selectedSexe = defaultSexe;
    fonctions = [defaultFct, 'Docteur', 'Réception'];
    orgs = [
      defaultOrg,
      'Docteur / Assistante Médical Dr Loucif',
      'Docteur / Assistante Médical Dr Diabi',
      'Docteur / Assistante Médical Dr Bekouche',
      'Docteur / Assistante Médical Dr Slougui'
    ];
    sexes = [defaultSexe, 'Homme', 'Femme'];

    nameController = TextEditingController();
    passController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
