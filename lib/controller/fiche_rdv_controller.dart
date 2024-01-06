import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  late DateTime dateRdv;
  String defaultRap = 'Ce Jours',
      defaultRapPat = 'Cette Semaine',
      defaultRapSexe = '2023',
      heureArrivee = "";
  bool loadingPat = false,
      valider = false,
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
      chargerInfo(codeBarre);
    }
  }

  chargerInfo(codeBarre) {
    _infoPatient(codeBarre);
    _infoRdv(codeBarre);
  }

  updateDateRdv(DateTime date) {
    //   if (date.weekday != DateTime.friday)
    dateRdv = date;
    update();
  }

  _infoPatient(String codebarre) async {
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

  _infoRdv(String codebarre) async {
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

  _updateValider({required bool newValider, newInscr = false}) {
    valider = newValider;
    update();
  }

  saveClasse() {
    if (p == null) {
      AppData.mySnackBar(
          color: AppColor.red,
          title: 'Fiche Rendez-vous',
          message: "Veuillez choisir un patient !!!!");
    } else {
      _updateValider(newValider: true, newInscr: false);
      if (r == null) {
        _insertClasse();
      } else {
        _updateClasse();
      }
    }
  }

  getBody() {
    if (DateFormat('yMMdd').format(dateRdv) ==
        DateFormat('yMMdd').format(DateTime.now())) {
      heureArrivee = DateFormat('kk:mm:ss').format(DateTime.now());
    } else {
      heureArrivee = "";
    }
    var body = {
      "ID_RDV": r == null ? "0" : r!.id.toString(),
      "CODE_BARRE": p!.codeBarre,
      "DATE_RDV": DateFormat('yMMdd').format(dateRdv),
      "HEURE_ARRIVEE": heureArrivee,
      "MOTIF": motifController.text
    };
    return body;
  }

  _insertClasse() async {
    await insertData(
            urlFile: "INSERT_RDV.php", nomFiche: "Rendez-vous", body: getBody())
        .then((value) {
      if (value.success) {
        debugPrint("value.data=${value.data}");
        Get.back();
      } else {
        _updateValider(newValider: false);
      }
    });
  }

  _updateClasse() async {
    await updateDeleteData(
            urlFile: "UPDATE_RDV.php", nomFiche: "Rendez-vous", body: getBody())
        .then((value) {
      if (value) {
        debugPrint("value=$value");
        Get.back();
      } else {
        _updateValider(newValider: false);
      }
    });
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
