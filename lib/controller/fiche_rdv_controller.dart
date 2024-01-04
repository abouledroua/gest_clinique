import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/patient.dart';
import '../core/class/rdv.dart';
import '../core/constant/color.dart';
import '../core/constant/data.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';
import '../core/services/settingservice.dart';

class FicheRdvController extends GetxController {
  late TextEditingController motifController, codebarreController;
  Patient? p;
  RDV? r;
  late int idRdv;
  late DateTime dateRdv;
  String defaultRap = 'Ce Jours',
      defaultRapPat = 'Cette Semaine',
      defaultRapSexe = '2023';
  bool loadingPat = false,
      errorPat = false,
      loadingRdv = false,
      errorRdv = false;
  List<String> dropRap = [], dropRapSexe = [], dropRapPat = [];
  String? selectedRap, selectedRapSexe, selectedRapPat;

  FicheRdvController({String codeBarre = ""}) {
    SettingServices c = Get.find();
    if (codeBarre.isEmpty) {
      codeBarre = c.sharedPrefs.getString('FICHE_RDV_CODE_BARRE') ?? '';
    }
    if (codeBarre.isNotEmpty) {
      c.sharedPrefs.setString('FICHE_RDV_CODE_BARRE', codeBarre);
      infoPatient(codeBarre);
      infoRdv(codeBarre);
    }
  }

  updateDateRdv(DateTime date) {
    if (date.weekday != DateTime.friday) dateRdv = date;
    update();
  }

  infoPatient(String codebarre) async {
    _updateBooleansPat(newloading: true, newerror: false);
    await getInfoPatient(codebarre).then((value) {
      p = value;
      if (codebarreController.text.isNotEmpty) {
        if (p == null) {
          AppData.mySnackBar(
              title: 'Fiche Rendez-vous',
              message: 'Code Barre erronée !!!',
              color: AppColor.red);
        } else {
          SettingServices c = Get.find();
          c.sharedPrefs
              .setString('FICHE_RDV_CODE_BARRE', codebarreController.text);
        }
        codebarreController.text = '';
      }
      _updateBooleansPat(newloading: false, newerror: p == null);
    });
  }

  infoRdv(String codebarre) async {
    _updateBooleansRdv(newloading: true, newerror: false);
    await getInfoRdv(codeBarre: codebarre).then((value) {
      r = value;
      _updateBooleansRdv(newloading: false, newerror: p == null);
    });
  }

  _updateBooleansPat({required newloading, required newerror}) {
    loadingPat = newloading;
    errorPat = newerror;
    update();
  }

  _updateBooleansRdv({required newloading, required newerror}) {
    loadingRdv = newloading;
    errorRdv = newerror;
    update();
  }

  updateDropRap(String? value) {
    selectedRap = value;
    update();
  }

  updateDropRapSexe(String? value) {
    selectedRapSexe = value;
    update();
  }

  updateDropRapPat(String? value) {
    selectedRapPat = value;
    update();
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    codebarreController = TextEditingController();
    motifController = TextEditingController();
    dateRdv = DateTime.now();
    selectedRap = defaultRap;
    dropRap = [defaultRap, 'Ce Mois', 'Cette Année', 'Tous'];

    selectedRapPat = defaultRapPat;
    dropRapPat = [defaultRapPat, 'Ce Mois', 'Cette Année', 'Tous'];

    selectedRapSexe = defaultRapSexe;
    dropRapSexe = ['2020', '2021', '2022', defaultRapSexe, 'Tous'];
  }

  @override
  void onClose() {
    codebarreController.dispose();
    motifController.dispose();
    SettingServices c = Get.find();
    c.sharedPrefs.setString('FICHE_RDV_CODE_BARRE', '');
    super.onClose();
  }
}
