import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/patient.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class PatientController extends GetxController {
  bool loading = false, error = false, load = false;
  List<Patient> patients = [], showList = [];
  String queryName = "";

  _updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  getPatients({bool show = true}) async {
    if (!load) {
      load = true;
      if (show) _updateBooleans(newloading: true, newerror: false);
      await getDataList(urlFile: "GET_PATIENTS.php", nomFiche: "Patient")
          .then((data) {
        if (data.success) {
          List<Patient> list = [];
          Patient p;
          for (var item in data.data) {
            try {
              p = Patient(
                  adresse: item['ADRESSE'],
                  age: int.parse(item['AGE']),
                  codeBarre: item['CODE_BARRE'],
                  convention: int.parse(item['CONVENTIONNE']) == 1,
                  dateNaissance: item['DATE_NAISSANCE'],
                  email: item['EMAIL'],
                  dette: double.parse(item['DETTE']),
                  gs: int.parse(item['GS']),
                  lieuNaissance: item['LIEU_NAISSANCE'],
                  nom: item['NOM'],
                  fullname: item['NOM'] + '  ' + item['PRENOM'],
                  prcConvention: double.parse(item['POURC_CONV']),
                  prenom: item['PRENOM'],
                  profession: item['PROFESSION'],
                  codeMalade: item['CODE_MALADE'],
                  sexe: int.parse(item['SEXE']),
                  isHomme: int.parse(item['SEXE']) == 1,
                  isFemme: int.parse(item['SEXE']) == 2,
                  tel1: item['TEL'],
                  tel2: item['TEL2'],
                  typeAge: int.parse(item['TYPE_AGE']));
              list.add(p);
            } catch (e) {
              debugPrint(' **** error : $e  ****');
            }
          }
          patients = list;
          filterList();
        } else {
          if (show) _updateBooleans(newloading: false, newerror: true);
        }
        load = false;
      });
    }
  }

  getPatientTimer() {
    getPatients(show: patients.isEmpty);
    Timer.periodic(const Duration(seconds: 2), (timer) {
      getPatients(show: patients.isEmpty);
    });
  }

  filterList() {
    showList = [];
    if (queryName != '') {
      for (var item in patients) {
        if (item.fullname.toUpperCase().contains(queryName.toUpperCase())) {
          showList.add(item);
        }
      }
    } else {
      showList = patients;
    }
    _updateBooleans(newloading: false, newerror: false);
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  _init() {
    queryName = "";
    AppSizes.setSizeScreen(Get.context);
    getPatientTimer();
  }
}
