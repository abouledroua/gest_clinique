import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/routes.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class RegisterUserController extends GetxController {
  late int idUser;
  late TextEditingController emailController, passController, nameController;
  String defaultOrg = 'Choisir votre Organisme',
      defaultFct = 'Votre Fonction',
      defaultSexe = 'Votre Sexe';
  List<String> orgs = [], fonctions = [], sexes = [];
  List<int> orgsId = [];
  late String selectedOrg, selectedFonction, selectedSexe;
  bool loading = false,
      valDes = false,
      valEmail = false,
      valider = false,
      error = false,
      inscr = false;

  RegisterUserController({required this.idUser});

  _updateValider({required bool newValider, newInscr = false}) {
    valider = newValider;
    inscr = newInscr;
    update();
  }

  saveClasse() {
    _updateValider(newValider: true, newInscr: false);
    valDes = nameController.text.isEmpty;
    valEmail = emailController.text.isEmpty;
    if (valDes || valEmail) {
      _updateValider(newValider: false, newInscr: false);
      AppData.mySnackBar(
          color: AppColor.red,
          title: 'Fiche Utilisateur',
          message: "Veuillez remplir les champs oligatoire !!!!");
    } else {
      if (selectedOrg == defaultOrg) {
        _updateValider(newValider: false, newInscr: false);
        AppData.mySnackBar(
            color: AppColor.red,
            title: 'Fiche Utilisateur',
            message: "Veuillez choisir un organisme !!!");
      } else {
        if (selectedFonction == defaultFct) {
          _updateValider(newValider: false, newInscr: false);
          AppData.mySnackBar(
              color: AppColor.red,
              title: 'Fiche Utilisateur',
              message:
                  "Veuillez choisir votre fonction aux sein de cet organisme !!!");
        } else {
          _existClasse();
        }
      }
    }
  }

  _existClasse() async {
    await existData(
            urlFile: "EXIST_USER.php",
            idField: 'ID_USER',
            nomFiche: 'Utilisateur',
            body: {"EMAIL": emailController.text, "ID_USER": idUser.toString()})
        .then((value) {
      if (value.success) {
        int result = value.data;
        if (result == 0) {
          debugPrint("Utilisateur n'existe pas ...");
          if (idUser == 0) {
            _insertClasse();
          } else {
            _updateClasse();
          }
        } else {
          _updateValider(newValider: false);
          AppData.mySnackBar(
              title: 'Fiche Utilisateur',
              message: "Ce Utilisateur existe déjà !!!",
              color: AppColor.red);
        }
      } else {
        _updateValider(newValider: false);
      }
    });
  }

  getBody() {
    int sexe = (sexes.indexOf(selectedSexe) - 1);
    int fct = (fonctions.indexOf(selectedFonction) - 1);
    var body = {
      "ID_USER": idUser.toString(),
      "PASSWORD": passController.text,
      "NAME": nameController.text,
      "EMAIL": emailController.text,
      "SEXE": sexe.toString(),
      "TYPE": fct.toString(),
      "ID_CABINET": fct.toString(),
      "FONCTION": "1"
    };
    return body;
  }

  _insertClasse() async {
    await insertData(
            urlFile: "INSERT_USER.php",
            nomFiche: "Utilisateur",
            body: getBody())
        .then((value) {
      if (value) {
        _updateValider(newValider: false, newInscr: true);
        Timer(const Duration(seconds: 3), _gotoLogin);
      } else {
        _updateValider(newValider: false);
      }
    });
  }

  _updateClasse() async {
    await updateData(
            urlFile: "UPDATE_USER.php",
            nomFiche: "Utilisateur",
            body: getBody())
        .then((value) {
      if (value) {
        _updateValider(newValider: false, newInscr: true);
        inscr = true;
        update();
        Timer(const Duration(seconds: 3), _gotoLogin);
      } else {
        _updateValider(newValider: false);
      }
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

  _updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  getOrganismes() async {
    await getDataList(urlFile: "GET_CABINETS.php", nomFiche: "Organisation")
        .then((value) {
      if (value.success) {
        var responsebody = value.data;
        orgs = [defaultOrg];
        orgsId = [0];
        for (var m in responsebody) {
          orgs.add(m['DESIGNATION']);
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
    inscr = false;

    selectedOrg = defaultOrg;

    selectedFonction = defaultFct;
    fonctions = [defaultFct, 'Docteur', 'Réception'];

    selectedSexe = defaultSexe;
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
