import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';
import 'login_controller.dart';
import 'register_user_controller.dart';

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
        _updateValider(newValue: false);
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
    int wilaya = (wilayas.indexOf(selectedWilaya) + 1);
    await existData(urlFile: "EXIST_CABINET.php", nomFiche: 'Cabinet', body: {
      "DESIGNATION": nameController.text,
      "WILAYA": wilaya.toString(),
      "ID_CABINET": idCabinet.toString()
    }).then((value) {
      if (value.success) {
        int result = 0;
        for (var m in value.data) {
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
      }
    });
  }

  getBody() {
    int wilaya = (wilayas.indexOf(selectedWilaya));
    var body = {
      "ID_CABINET": idCabinet.toString(),
      "DESIGNATION": nameController.text,
      "EMAIL": emailController.text,
      "TEL": telController.text,
      "WILAYA": wilaya.toString(),
      "ADRESSE": adrController.text
    };
    return body;
  }

  _insertClasse() async {
    await insertData(
            urlFile: "INSERT_CABINET.php", nomFiche: "Cabinet", body: getBody())
        .then((value) {
      if (value.success) {
        _updateValider(newValue: false);
        inscr = true;
        update();
        Timer(const Duration(seconds: 2), _goBack);
      } else {
        _updateValider(newValue: false);
      }
    });
  }

  _updateClasse() async {
    await updateDeleteData(
            nomFiche: "Cabinet", urlFile: "UPDATE_CABINET.php", body: getBody())
        .then((value) {
      if (value) {
        _updateValider(newValue: false);
        inscr = true;
        update();
        Timer(const Duration(seconds: 3), _goBack);
      } else {
        _updateValider(newValue: false);
      }
    });
  }

  updateDropWilaya(String value) {
    selectedWilaya = value;
    update();
  }

  _goBack() {
    if (Get.isRegistered<LoginController>()) {
      // LoginController controller = Get.find();
      // controller.getOrganismes();
    }
    if (Get.isRegistered<RegisterUserController>()) {
      RegisterUserController controller = Get.find();
      controller.getOrganismes();
    }
    Get.back();
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
    selectedWilaya = defaultWilaya;
    wilayas = [defaultWilaya];
    wilayas.addAll(AppData.wilayas);

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
