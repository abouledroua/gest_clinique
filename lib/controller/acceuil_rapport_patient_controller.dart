import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class AcceuilRapportPatientController extends GetxController {
  String defaultRapPat = 'Cette Semaine';
  List<String> dropRapPat = [], libDuree = [];
  List<double> vals = [];
  bool loading = false, error = true, load = false;
  String? selectedRapPat;

  updateDropRapPat(String? value) {
    selectedRapPat = value;
    getData();
  }

  _updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  getBody() {
    var body = {};
    int type = dropRapPat.indexOf(selectedRapPat!);
    body["TYPE"] = type.toString();
    libDuree = [];
    switch (type) {
      case 0:
        // DateTime date = DateTime.parse("20231202");
        DateTime date = DateTime.now();
        libDuree.add(DateFormat('yMMdd').format(date));
        int nbDays = (type == 0) ? 7 : 30;
        while (libDuree.length < nbDays) {
          date = DateTime(date.year, date.month, date.day - 1);
          if (date.weekday != 5) {
            libDuree.insert(0, DateFormat('yMMdd').format(date));
          }
        }
        body["DATES"] = libDuree.join(',');
        break;
      case 1:
        // DateTime dateNow = DateTime.parse("20231127");
        DateTime dateNow = DateTime.now();
        DateTime date = DateTime(dateNow.year, dateNow.month, 1);
        libDuree.add(DateFormat('yMMdd').format(date));
        while (date != dateNow && !(date.compareTo(dateNow) > 0)) {
          date = DateTime(date.year, date.month, date.day + 1);
          if (date.weekday != 5) {
            libDuree.add(DateFormat('yMMdd').format(date));
          }
        }
        body["DATES"] = libDuree.join(',');
        break;
      case 2:
        for (var i = 1; i < 13; i++) {
          libDuree.add(
              DateFormat('yMMdd').format(DateTime(DateTime.now().year, i, 1)));
        }
        break;
      default:
    }
    return body;
  }

  getData({bool show = true}) async {
    load = false;
    if (!load) {
      load = true;
      if (show) _updateBooleans(newloading: true, newerror: false);
      await getDataList(
              urlFile: "GET_RAPPORT_PATIENT_DATA.php",
              nomFiche: "Acceuil",
              body: getBody())
          .then((data) async {
        if (data.success) {
          vals = [];
          int i = 0;
          for (var item in data.data) {
            try {
              while (true) {
                vals.add(double.parse(item['D$i']));
                i++;
              }
            } catch (e) {
              break;
            }
          }
          debugPrint("data = $vals");
          await normaliseData();
        } else {
          if (show) _updateBooleans(newloading: false, newerror: true);
        }
        load = false;
      });
    }
  }

  getDataTimer() {
    getData(show: error);
    Timer.periodic(const Duration(seconds: 10), (timer) {
      getData(show: error);
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
    selectedRapPat = defaultRapPat;
    dropRapPat = [defaultRapPat, 'Ce Mois', 'Cette Année'];
    getDataTimer();
  }

  normaliseData() async {
    double minValue = vals.reduce(min);
    double maxValue = vals.reduce(max);
    if (maxValue - minValue > 6) {}
    _updateBooleans(newloading: false, newerror: false);
  }
}
