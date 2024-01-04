import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../class/patient.dart';
import '../class/rdv.dart';
import '../constant/color.dart';
import '../constant/data.dart';

Future<MyDataResponse> insertData(
    {required String urlFile, required String nomFiche, Object? body}) async {
  late MyDataResponse resp;
  String serverDir = AppData.getServerDirectory();
  var url = "$serverDir/$urlFile";
  debugPrint(url);
  Uri myUri = Uri.parse(url);
  return await http.post(myUri, body: body).then((response) async {
    if (response.statusCode == 200) {
      var responsebody = response.body;
      debugPrint("Cabinet Response=$responsebody");
      if (responsebody != "0") {
        resp = MyDataResponse(success: true, data: responsebody);
        return resp;
      } else {
        AppData.mySnackBar(
            title: 'Fiche $nomFiche',
            message: "Probleme lors de l'ajout !!!",
            color: AppColor.red);
        resp = MyDataResponse(success: false);
        return resp;
      }
    } else {
      AppData.mySnackBar(
          title: 'Fiche $nomFiche',
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red);
      resp = MyDataResponse(success: false);
      return resp;
    }
  }).catchError((error) {
    debugPrint("erreur insertClasse: $error");
    AppData.mySnackBar(
        title: 'Fiche $nomFiche',
        message: "Probleme de Connexion avec le serveur !!!",
        color: AppColor.red);
    resp = MyDataResponse(success: false);
    return resp;
  });
}

Future<bool> updateDeleteData(
    {required String urlFile, required String nomFiche, Object? body}) async {
  String serverDir = AppData.getServerDirectory();
  var url = "$serverDir/$urlFile";
  debugPrint(url);
  Uri myUri = Uri.parse(url);
  return await http.post(myUri, body: body).then((response) async {
    if (response.statusCode == 200) {
      var responsebody = response.body;
      debugPrint("$nomFiche Response = $responsebody");
      if (responsebody != "0") {
        return true;
      } else {
        AppData.mySnackBar(
            title: 'Fiche $nomFiche',
            message: "Probleme lors de la mise a jour des informations !!!",
            color: AppColor.red);
        return false;
      }
    } else {
      AppData.mySnackBar(
          title: 'Fiche $nomFiche',
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red);
      return false;
    }
  }).catchError((error) {
    debugPrint("erreur update$nomFiche: $error");
    AppData.mySnackBar(
        title: 'Fiche $nomFiche',
        message: "Probleme de Connexion avec le serveur !!!",
        color: AppColor.red);
    return false;
  });
}

Future<MyDataResponse> existData(
    {required String urlFile, required String nomFiche, Object? body}) async {
  late MyDataResponse resp;
  String serverDir = AppData.getServerDirectory();
  var url = "$serverDir/$urlFile";
  debugPrint(url);
  Uri myUri = Uri.parse(url);
  return await http
      .post(myUri, body: body)
      .timeout(AppData.getTimeOut())
      .then((response) async {
    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      resp = MyDataResponse(success: true, data: responsebody);
      return resp;
    } else {
      AppData.mySnackBar(
          title: 'Fiche $nomFiche',
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red);
      resp = MyDataResponse(success: false);
      return resp;
    }
  }).catchError((error) {
    debugPrint("erreur _exist$nomFiche: $error");
    AppData.mySnackBar(
        title: 'Fiche $nomFiche',
        message: "Probleme de Connexion avec le serveur !!!",
        color: AppColor.red);
    resp = MyDataResponse(success: false);
    return resp;
  });
}

Future<MyDataResponse> getDataList(
    {required String urlFile, required String nomFiche, Object? body}) async {
  late MyDataResponse resp;
  String serverDir = AppData.getServerDirectory();
  var url = "$serverDir/$urlFile";
  debugPrint("url=$url");
  Uri myUri = Uri.parse(url);
  return await http
      .post(myUri, body: body)
      .timeout(AppData.getTimeOut())
      .then((response) async {
    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      resp = MyDataResponse(success: true, data: responsebody);
      return resp;
    } else {
      resp = MyDataResponse(success: false);
      return resp;
    }
  }).catchError((error) async {
    debugPrint("erreur get$nomFiche: $error");
    resp = MyDataResponse(success: false);
    return resp;
  });
}

Future<Patient?> getInfoPatient(String codeBarre) async {
  return await getDataList(
      urlFile: "GET_PATIENTS.php",
      nomFiche: "Patient",
      body: {"CODE_BARRE": codeBarre}).then((data) {
    if (data.success) {
      Patient? p;
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
      }
      return p;
    } else {
      return null;
    }
  });
}

Future<RDV?> getInfoRdv(int idRdv) async {
  return await getDataList(
      urlFile: "GET_RDVS.php",
      nomFiche: "Rendez-vous",
      body: {"ID_RDV": idRdv.toString()}).then((data) {
    if (data.success) {
      RDV? r;
      for (var item in data.data) {
        r = RDV(
            codeBarre: item['CODE_BARRE'],
            nom: item['NOM'],
            prenom: item['PRENOM'],
            age: int.parse(item['AGE']),
            typeAge: int.parse(item['TYPE_AGE']),
            motif: item['DES_MOTIF'],
            etatRDV: int.parse(item['ETAT_RDV']),
            heureArrivee: item['HEURE_ARRIVEE'],
            id: int.parse(item['ID']),
            consult: int.parse(item['CONSULT']) == 1,
            dette: double.parse(item['DETTE']),
            versement: double.parse(item['VERSEMENT']),
            sexe: int.parse(item['SEXE']));
      }
      return r;
    } else {
      return null;
    }
  });
}

class MyDataResponse {
  bool success;
  dynamic data;
  MyDataResponse({required this.success, this.data});
}
