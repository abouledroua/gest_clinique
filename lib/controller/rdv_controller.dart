import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/class/rdv.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class RDVController extends GetxController {
  bool loading = false, error = false, load = false;
  List<RDV> rdvs = [];

  _updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  getRdvs({bool show = true}) async {
    if (!load) {
      load = true;
      if (show) _updateBooleans(newloading: true, newerror: false);
      String date = DateFormat('yMMdd').format(DateTime.now());
      var body = {"DATE": date};
      await getDataList(
              urlFile: "GET_RDVS.php", nomFiche: "Rendez-vous", body: body)
          .then((data) {
        if (data.success) {
          List<RDV> list = [];
          late RDV r;
          for (var item in data.data) {
            try {
              r = RDV(
                  sexe: int.parse(item['SEXE']),
                  id: int.parse(item['ID']),
                  age: int.parse(item['AGE']),
                  codeBarre: item['CODE_BARRE'],
                  heureArrivee: item['HEURE_ARRIVEE'],
                  consult: int.parse(item['CONSULT']) == 1,
                  dette: double.parse(item['DETTE']),
                  etatRDV: int.parse(item['ETAT_RDV']),
                  dateRdv: item['DATE'],
                  motif: item['DES_MOTIF'],
                  nom: item['NOM'],
                  prenom: item['PRENOM'],
                  typeAge: int.parse(item['TYPE_AGE']),
                  versement: double.parse(item['VERSEMENT']));
              list.add(r);
            } catch (e) {
              debugPrint(' **** error : $e  ****');
            }
          }
          rdvs = list;
          _updateBooleans(newloading: false, newerror: false);
        } else {
          if (show) _updateBooleans(newloading: false, newerror: true);
        }
        load = false;
      });
    }
  }

  getRdvTimer() {
    getRdvs(show: rdvs.isEmpty);
    Timer.periodic(const Duration(seconds: 2), (timer) {
      getRdvs(show: rdvs.isEmpty);
    });
  }

  removeRdv(int idRdv) async {
    await AwesomeDialog(
            context: Get.context!,
            dialogType: DialogType.question,
            title: 'Suppression',
            btnOkText: "Oui",
            btnCancelText: "Non",
            width: min(AppSizes.widthScreen, 400),
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              deleteRdv(idRdv);
            },
            showCloseIcon: true,
            desc: 'Voulez-vous vraiment supprimer ce rendez-vous ??')
        .show();
  }

  deleteRdv(int idRdv) async {
    await updateDeleteData(
        urlFile: "DELETE_RDV.php",
        nomFiche: "Rendez-vous",
        body: {"ID_RDV": idRdv.toString()}).then((value) {
      if (value) {
        getRdvs();
      }
    });
  }

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  getNbRdvs({int etat = -1, int sexe = -1}) {
    int nb = 0;
    for (var item in rdvs) {
      if (etat != -1) {
        switch (etat) {
          case 0:
            if (!item.consult && item.etatRDV == etat) nb++;
            break;
          case 1:
            if (!item.consult && item.etatRDV == etat) nb++;
            break;
          case 2:
            if (item.consult) nb++;
            break;
          default:
        }
      } else {
        if (item.sexe == sexe) nb++;
      }
    }
    return nb;
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    getRdvTimer();
  }
}
