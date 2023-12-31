import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/patient.dart';
import '../core/class/rdv.dart';
import '../core/constant/sizes.dart';

class RDVController extends GetxController {
  bool loading = false;
  List<RDV> rdvs = [];
  List<String> names = [
    'Rahim',
    'Karim',
    'Bilel',
    'Amor',
    'Mohamed',
    'Mohammed Amine',
    'AbdelKader',
    'Ali',
    'Rabeh',
    "Said",
    "Louai",
    'Lakhder'
  ];

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    _init();
    super.onInit();
  }

  chargerRdvs() async {
    loading = true;
    update();
    rdvs = [];
    var rng = Random();
    Patient p;
    RDV r;
    int l, j, k, e, id = 0, s, nbRdvs = rng.nextInt(250) + 3;
    DateTime date = DateTime.now();
    for (var i = 0; i < nbRdvs; i++) {
      id++;
      rng = Random();
      l = rng.nextInt(names.length);
      rng = Random();
      j = rng.nextInt(names.length);
      rng = Random();
      k = rng.nextInt(3849594848);
      rng = Random();
      e = rng.nextInt(3);
      rng = Random();
      s = rng.nextInt(2) + 1;
      p = Patient(
          id: id,
          nom: names[l],
          prenom: names[j],
          codeBarre: k.toString(),
          email: 'email@gmail.com',
          dateNaissance: '22/02/2000',
          adresse: 'adresse',
          lieuNaissance: 'lieuNaissance',
          profession: 'profession',
          age: rng.nextInt(80) + 3,
          typeAge: 1,
          convention: false,
          prcConvention: 0,
          sexe: s,
          gs: 0,
          tel1: '0555 555 555',
          tel2: '0777 777 777');
      r = RDV(
          patient: p,
          dateRdv: '${date.year}${date.month}${date.day}',
          etat: e,
          dateDernConsult: '20230212');
      rdvs.add(r);
    }
    loading = false;
    update();
  }

  getNbRdvs({int etat = -1, int sexe = -1}) {
    int nb = 0;
    for (var item in rdvs) {
      if (etat != -1) {
        if (item.etat == etat) nb++;
      } else {
        if (item.patient.sexe == sexe) nb++;
      }
    }
    return nb;
  }

  _init() {
    AppSizes.setSizeScreen(Get.context);
    chargerRdvs();
  }
}
