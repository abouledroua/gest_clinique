import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class AcceuilSexeChartController extends GetxController {
  String defaultRapSexe = DateTime.now().year.toString();
  double nbHomme = 0, nbFemme = 0, nbTotalSexe = 0;
  List<String> dropRapSexe = [];
  bool loadingSexeList = false,
      errorSexeList = false,
      loadSexeList = false,
      loadingSexeData = false,
      errorSexeData = false,
      loadSexeData = false;
  String? selectedRapSexe;

  updateDropRapSexe(String? value) {
    selectedRapSexe = value;
    getSexeData(show: true);
  }

  _updateBooleansSexeList({required newloading, required newerror}) {
    loadingSexeList = newloading;
    errorSexeList = newerror;
    update();
  }

  _updateBooleansSexeData({required newloading, required newerror}) {
    loadingSexeData = newloading;
    errorSexeData = newerror;
    update();
  }

  getSexeList({bool show = true}) async {
    if (!loadSexeList) {
      loadSexeList = true;
      if (show) _updateBooleansSexeList(newloading: true, newerror: false);
      await getDataList(
              urlFile: "GET_RAPPORT_SEXE_LIST.php", nomFiche: "Acceuil")
          .then((data) {
        if (data.success) {
          dropRapSexe = [];
          int year;
          bool existExerciceEncours = false;
          for (var item in data.data) {
            try {
              year = int.parse(item['ANNEE']);
              if (year == DateTime.now().year) {
                existExerciceEncours = true;
              } else if (year > DateTime.now().year && !existExerciceEncours) {
                dropRapSexe.add(DateTime.now().year.toString());
                existExerciceEncours = true;
              }
              dropRapSexe.add(item['ANNEE']);
            } catch (e) {
              debugPrint(' **** error : $e  ****');
            }
          }
          if (!existExerciceEncours) {
            dropRapSexe.add(DateTime.now().year.toString());
          }
          _updateBooleansSexeList(newloading: false, newerror: false);
        } else {
          if (show) _updateBooleansSexeList(newloading: false, newerror: true);
        }
        loadSexeList = false;
        getSexeData(show: show);
      });
    }
  }

  getSexeData({bool show = true}) async {
    if (!loadSexeData) {
      loadSexeData = true;
      if (show) _updateBooleansSexeData(newloading: true, newerror: false);
      await getDataList(
          urlFile: "GET_RAPPORT_SEXE_DATA.php",
          nomFiche: "Acceuil",
          body: {"YEAR": selectedRapSexe}).then((data) {
        if (data.success) {
          nbHomme = 0;
          nbFemme = 0;
          nbTotalSexe = 0;
          for (var item in data.data) {
            try {
              nbHomme = double.parse(item['NB_HOMME']);
              nbFemme = double.parse(item['NB_FEMME']);
              nbTotalSexe = nbHomme + nbFemme;
            } catch (e) {
              debugPrint(' **** error : $e  ****');
            }
          }
          _updateBooleansSexeData(newloading: false, newerror: false);
        } else {
          if (show) _updateBooleansSexeData(newloading: false, newerror: true);
        }
        loadSexeData = false;
      });
    }
  }

  getSexeDataTimer() {
    getSexeList(show: dropRapSexe.isEmpty);
    Timer.periodic(const Duration(minutes: 1), (timer) {
      getSexeList(show: dropRapSexe.isEmpty);
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
    getSexeDataTimer();

    selectedRapSexe = defaultRapSexe;
    dropRapSexe = ['2020', '2021', '2022', defaultRapSexe];
  }
}
