import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/patient.dart';
import '../core/class/rdv.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class FicheRdvController extends GetxController {
  late TextEditingController motifController;
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

  FicheRdvController({String codeBarre = "", int idrdv = 0}) {
    idRdv = idrdv;
    if (idRdv != 0) {
      infoRdv();
    }
    if (codeBarre.isNotEmpty) {
      infoPatient(codeBarre);
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
      _updateBooleansPat(newloading: false, newerror: p == null);
    });
  }

  infoRdv() async {
    _updateBooleansRdv(newloading: true, newerror: false);
    await getInfoRdv(idRdv).then((value) {
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
    motifController.dispose();
    super.onClose();
  }
}
