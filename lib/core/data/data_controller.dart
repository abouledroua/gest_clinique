import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

Future<bool> updateData(
    {required String urlFile, required String nomFiche, Object? body}) async {
  String serverDir = AppData.getServerDirectory();
  var url = "$serverDir/$urlFile";
  debugPrint(url);
  Uri myUri = Uri.parse(url);
  return await http.post(myUri, body: body).then((response) async {
    if (response.statusCode == 200) {
      var responsebody = response.body;
      debugPrint("Cabinet Response = $responsebody");
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
    debugPrint("erreur updateClasse: $error");
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

class MyDataResponse {
  bool success;
  dynamic data;
  MyDataResponse({required this.success, this.data});
}
