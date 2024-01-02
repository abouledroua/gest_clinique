import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/class/rdv.dart';
import '../core/constant/sizes.dart';
import '../core/data/data_controller.dart';

class RDVController extends GetxController {
  bool loading = false, error = false;
  List<RDV> rdvs = [];

  _updateBooleans({required newloading, required newerror}) {
    loading = newloading;
    error = newerror;
    update();
  }

  getRdvs() async {
    _updateBooleans(newloading: true, newerror: false);
    String date = DateFormat('yMMdd').format(DateTime.now());
    var body = {"DATE": date};
    await getDataList(
            urlFile: "GET_RDVS.php", nomFiche: "Rendez-vous", body: body)
        .then((data) {
      if (data.success) {
        rdvs = [];
        late RDV r;
        for (var item in data.data) {
          r = RDV(
              sexe: int.parse(item['SEXE']),
              age: int.parse(item['AGE']),
              codeBarre: item['CODE_BARRE'],
              consult: int.parse(item['CONSULT']) == 1,
              dette: double.parse(item['DETTE']),
              etatRDV: int.parse(item['ETAT_RDV']),
              motif: item['DES_MOTIF'],
              nom: item['NOM'],
              prenom: item['PRENOM'],
              typeAge: int.parse(item['TYPE_AGE']),
              versement: double.parse(item['VERSEMENT']));
          rdvs.add(r);
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
    getRdvs();
    // chargerRdvs();
  }
}
