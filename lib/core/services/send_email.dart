import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

import '../constant/color.dart';
import '../constant/data.dart';

String _myKey = '';

Future _sendEmail(
    {required String toEmail,
    required String parentName,
    required int type}) async {
  final smtpServer = SmtpServer('mail.atlasschool.dz',
      port: 465,
      ssl: true,
      name: 'ATLAS SCHOOL',
      username: 'admin@atlasschool.dz',
      password: 'admin_2023');

  const email = 'admin@atlasschool.dz';
  final message = Message()
    ..from = const Address(email, 'ATLAS SCHOOL')
    ..recipients = [toEmail]
    ..text = (type == 1)
        ? _getActivationText(
            parentName: parentName, key: _myKey, email: toEmail)
        : _getNewAnnonceText(parentName: parentName, email: toEmail)
    ..subject =
        "Ecole ATLAS SCHOOL '${type == 1 ? 'Création du compte' : 'Nouvelle Annonce'}'";
  try {
    await send(message, smtpServer);
    if (type == 1) {
      AppData.mySnackBar(
          title: 'Email',
          message: 'Email envoyé avec succés',
          color: AppColor.green);
    }
  } on MailerException catch (e) {
    debugPrint(e.toString());
  }
}

_genererKey() {
  _myKey = '';
  int nb;
  for (var i = 0; i < 6; i++) {
    nb = Random().nextInt(16);
    _myKey += nb.toRadixString(16);
  }
  _myKey = _myKey.toUpperCase();
}

sendEmail(
    {required String toEmail, required String parentName, required int type}) {
  // type : 1 // activation mail  -- 2 // new annonce mail
  if (type == 1) {
    _genererKey();
    String serverDir = AppData.getServerDirectory();
    var url = "$serverDir/UPDATE_KEY.php";
    debugPrint(url);
    Uri myUri = Uri.parse(url);
    http.post(myUri, body: {"EMAIL": toEmail, "KEY": _myKey}).then(
        (response) async {
      if (response.statusCode == 200) {
        var responsebody = response.body;
        debugPrint("_sendKey Response=$responsebody");
        if (responsebody != "0") {
          _sendEmail(parentName: parentName, toEmail: toEmail, type: type);
        } else {
          AppData.mySnackBar(
              title: 'Envoi Email',
              message: "Probleme lors de l'envoi de l'email !!!",
              color: AppColor.red);
        }
      } else {
        AppData.mySnackBar(
            title: 'Envoi Email',
            message: "Probleme de Connexion avec le serveur !!!",
            color: AppColor.red);
      }
    }).catchError((error) {
      debugPrint("erreur _sendKey: $error");
      AppData.mySnackBar(
          title: 'Envoi Email',
          message: "Probleme de Connexion avec le serveur !!!",
          color: AppColor.red);
    });
  } else {
    _sendEmail(parentName: parentName, toEmail: toEmail, type: type);
  }
}

_getActivationText(
    {required String parentName, required String email, required String key}) {
  String myLink = "https://atlasschool.dz/#/login/$email&&$key";
  String s = "Bonjour $parentName\n";
  s +=
      "\tNous avons l'honneur de vous informer que votre compte au niveau de l'application ATLAS SCHOOL a été activé.\n";
  s +=
      "\tVeuillez utiliser le lien suivant pour accéder à l'application : $myLink\n";
  s +=
      "\tSi votre appareil est Android, vous devez télécharger et installer l'application via le lien : https://play.google.com/store/apps/details?id=com.bouledrouaamor.atlas_school\n";
  s +=
      "Pour plus d'information, veuillez contacter l'administration de l'école ATLAS SCHOOL\n";
  s += "Tel : 0673 11 51 79\n";
  s += "Email : atlasschool.alg@gmail.com";
  s += "\nCordialement,\n";

  return s;
}

_getNewAnnonceText({required String parentName, required String email}) {
  String myLink = "https://atlasschool.dz/#/ListAnnonces";
  String s = "Bonjour $parentName\n";
  s +=
      "\tL'école ATLAS SCHOOL a publiée une nouvelle annonce sur son application.\n";
  s += "\tVeuillez utiliser le lien suivant pour voir l'annonce : $myLink\n";
  s +=
      "Pour plus d'information, veuillez contacter l'administration de l'école ATLAS SCHOOL\n";
  s += "Tel : 0673 11 51 79\n";
  s += "Email : atlasschool.alg@gmail.com";
  s += "\nCordialement,\n";

  return s;
}
