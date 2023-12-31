import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';

class RegisterCabinetController extends GetxController {
  late int idCabinet;
  late TextEditingController emailController,
      telController,
      nameController,
      adrController;
  String defaultWilaya = 'Choisir votre Wilaya';
  late String selectedWilaya;
  List<String> wilayas = [];
  bool loading = false,
      valDes = false,
      valider = false,
      error = false,
      inscr = false;

  RegisterCabinetController({required this.idCabinet});

  _updateValider({required bool newValue}) {
    valider = newValue;
    update();
  }

  saveClasse() {
    inscr = false;
    _updateValider(newValue: true);
    valDes = nameController.text.isEmpty;
    if (valDes) {
      debugPrint("Veuillez saisir les champs obligatoires !!!!");
      _updateValider(newValue: false);
      AppData.mySnackBar(
          color: AppColor.red,
          title: 'Fiche Cabinet',
          message: "Veuillez remplir les champs oligatoire !!!!");
    } else {
      if (selectedWilaya == defaultWilaya) {
        AppData.mySnackBar(
            color: AppColor.red,
            title: 'Fiche Cabinet',
            message: "Veuillez choisir la wilaya !!!");
      } else {
        _existClasse();
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
              debugPrint("Cabinet n'existe pas ...");
              if (idCabinet == 0) {
                _insertClasse();
              } else {
                _updateClasse();
              }
            } else {
              _updateValider(newValue: false);
              AppData.mySnackBar(
                  title: 'Fiche Cabinet',
                  message: "Ce Cabinet existe déjà !!!",
                  color: AppColor.red);
            }
          } else {
            _updateValider(newValue: false);
            AppData.mySnackBar(
                title: 'Fiche Cabinet',
                message: "Probleme de Connexion avec le serveur !!!",
                color: AppColor.red);
          }
        })
        .catchError((error) {
          debugPrint("erreur _existClasse: $error");
          _updateValider(newValue: false);
          AppData.mySnackBar(
              title: 'Fiche Cabinet',
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
        debugPrint("Cabinet Response=$responsebody");
        if (responsebody != "0") {
          // Get.back(result: "success");
          _updateValider(newValue: false);
          inscr = true;
          update();
          Timer(const Duration(seconds: 3), _gotoLogin);
        } else {
          _updateValider(newValue: false);
          AppData.mySnackBar(
              title: 'Fiche Cabinet',
              message: "Probleme lors de l'ajout !!!",
              color: AppColor.red);
        }
      } else {
        _updateValider(newValue: false);
        AppData.mySnackBar(
            title: 'Fiche Cabinet',
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red);
      }
    }).catchError((error) {
      debugPrint("erreur insertClasse: $error");
      _updateValider(newValue: false);
      AppData.mySnackBar(
          title: 'Fiche Cabinet',
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
        debugPrint("Cabinet Response = $responsebody");
        if (responsebody != "0") {
          // Get.back(result: "success");
          _updateValider(newValue: false);
          inscr = true;
          update();
          Timer(const Duration(seconds: 3), _gotoLogin);
        } else {
          _updateValider(newValue: false);
          AppData.mySnackBar(
              title: 'Fiche Cabinet',
              message: "Probleme lors de la mise a jour des informations !!!",
              color: AppColor.red);
        }
      } else {
        _updateValider(newValue: false);
        AppData.mySnackBar(
            title: 'Fiche Cabinet',
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red);
      }
    }).catchError((error) {
      debugPrint("erreur updateClasse: $error");
      _updateValider(newValue: false);
      AppData.mySnackBar(
          title: 'Fiche Cabinet',
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red);
    });
  }

  updateDropWilaya(String value) {
    selectedWilaya = value;
    update();
  }

  _gotoLogin() {
    Get.toNamed(AppRoute.login);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _initConnect();
    super.onInit();
  }

  _initConnect() {
    AppSizes.setSizeScreen(Get.context);
    inscr = false;
    selectedWilaya = defaultWilaya;
    wilayas = [
      defaultWilaya,
      'Adrar',
      'Chlef',
      'Laghouat',
      'Oum El Bouaghi',
      'Batna',
      'Bejaïa',
      'Biskra',
      'Béchar',
      'Blida',
      'Bouira',
      'Tamanrasset',
      'Tébessa',
      'Tlemcen',
      'Tiaret',
      'Tizi Ouzou',
      'Alger',
      'Djelfa',
      'Jijel',
      'Sétif',
      'Saïda',
      'Skikda',
      'Sidi Bel Abbés',
      'Annaba',
      'Guelma',
      'Constantine',
      'Médéa',
      'Mostaganem',
      "M'Sila",
      'Mascara',
      'Ouargla',
      'Oran',
      'Bayadh',
      'Illizi',
      'Bordj Bou Arreridj',
      'Boumerdés',
      'El Taref',
      'Tindouf',
      'Tissemsilt',
      'Oued',
      'Khenchela',
      'Souk Ahras',
      'Tipaza',
      'Mila',
      'Aïn Defla',
      'Naâma',
      'Aïn Témouchent',
      'Ghardaïa',
      'Relizane',
      'Timimoune',
      'Bordj Badji Mokhtar',
      'Ouled Djellal',
      'Béni Abbés',
      'In Salah',
      'In Guezzam',
      'Touggourt',
      'Djanet',
      "M'Ghair",
      'Meniaa'
    ];

    nameController = TextEditingController();
    adrController = TextEditingController();
    telController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    adrController.dispose();
    telController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
