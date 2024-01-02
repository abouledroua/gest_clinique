import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/class/patient.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class PatientController extends GetxController {
  bool loading = false, error = false;
  List<Patient> patients = [];

  _updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  getPatients() async {
    _updateBooleans(newloading: true, newerror: false);
    String date = DateFormat('yMMdd').format(DateTime.now());
    var body = {"DATE": date};
    await getDataList(
            urlFile: "GET_PATIENTS.php", nomFiche: "Rendez-vous", body: body)
        .then((data) {
      if (data.success) {
        patients = [];
        Patient p;
        for (var item in data.data) {
          p = Patient(
              adresse: item['ADRESSE'],
              age: int.parse(item['AGE']),
              codeBarre: item['CODE_BARRE'],
              convention: int.parse(item['CONVENTIONNE']) == 1,
              dateNaissance: item['DATE_NAISSANCE'],
              email: item['EMAIL'],
              gs: int.parse(item['GS']),
              lieuNaissance: item['LIEU_NAISSANCE'],
              nom: item['NOM'],
              prcConvention: double.parse(item['POURC_CONV']),
              prenom: item['PRENOM'],
              profession: item['PROFESSION'],
              codeMalade: item['CODE_MALADE'],
              sexe: int.parse(item['SEXE']),
              tel1: item['TEL'],
              tel2: item['TEL2'],
              typeAge: int.parse(item['TYPE_AGE']));
          patients.add(p);
        }
        _updateBooleans(newloading: false, newerror: false);
      } else {
        _updateBooleans(newloading: false, newerror: true);
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
    getPatients();
  }
}
