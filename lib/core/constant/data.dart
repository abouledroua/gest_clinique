import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:launch_review/launch_review.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../services/settingservice.dart';
import 'color.dart';
import 'routes.dart';
import 'sizes.dart';

class AppData {
  static const bool testMode = false;
  static double webVersion = 7.1, padBottom = 30;
  static const String _www = "ATLAS", localDdbName = 'datlas';
  static String _serverIP = testMode ? "192.168.1.161/ATLAS" : "atlasschool.dz";
  static const int widthSmallImage = 100,
      heightSmallImage = 100,
      bddVersion = 1;
  static const Duration _timeOut = Duration(seconds: 10);
  static int modeLogin = 0;
  static bool outdatedVersion = false;
  static Timer? internetLoginTimer;
  static late String storageLocation;
  static final bool isAndroidAppMobile =
      (defaultTargetPlatform == TargetPlatform.android && !kIsWeb);

  static String getServerIP() => _serverIP;

  static Duration getTimeOut() => _timeOut;

  static bool isVideo(path) {
    bool video = false;
    String? mimeStr = lookupMimeType(path);
    if (mimeStr != null) {
      var fileType = mimeStr.split('/');
      video = fileType[0] == 'video';
    }
    return video;
  }

  static String getServerDirectory([port = ""]) => ((_serverIP == "")
      ? ""
      : "http${testMode ? "" : "s"}://$_serverIP${port != "" ? ":$port" : ""}/$_www");

  static String getImage(pImage, pType) =>
      "${getServerDirectory()}/IMAGE/$pType/$pImage";

  static setServerIP(ip) async {
    _serverIP = ip;
    SettingServices c = Get.find();
    c.sharedPrefs.setString('ServerIp', _serverIP);
  }

  static mySnackBar({required title, required message, required color}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: AppSizes.widthScreen,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: color,
        colorText: AppColor.white);
  }

  static String printDateDayOnly(String pdate) {
    DateTime currentDate = DateTime.now();
    DateTime date = DateTime.parse(pdate);
    int yy = currentDate.year - date.year;
    String str = "";
    if (yy > 0) {
      str = DateFormat('yyyy-MM-dd').format(date);
    } else {
      int mm = currentDate.month - date.month;
      int dd = currentDate.day - date.day;
      if (mm < 0) {
        yy--;
        mm += 12;
      }
      if (dd < 0) {
        mm--;
        dd += 30;
      }
      if (dd > 6) {
        str = DateFormat('dd MMM à HH:mm').format(date);
      } else {
        switch (dd) {
          case 0:
            str = "Aujourdh'ui";
            break;
          case 1:
            str = "Hier";
            break;
          default:
            str = DateFormat('dd MMM').format(date);
            break;
        }
      }
    }
    return str;
  }

  static Uint8List resizeImage(Uint8List imageDataBig) {
    var image = img.decodeImage(imageDataBig);
    var imagea = img.copyResize(image!,
        width: AppData.widthSmallImage, height: AppData.heightSmallImage);
    var resized = img.encodePng(imagea);
    return Uint8List.fromList(resized);
  }

  static String printDate(DateTime? date) {
    DateTime currentDate = DateTime.now();
    int yy = currentDate.year - date!.year;
    String str = "";
    if (yy > 0) {
      str = DateFormat('yyyy-MM-dd').format(date);
    } else {
      int mm = currentDate.month - date.month;
      int dd = currentDate.day - date.day;
      int hh = currentDate.hour - date.hour;
      int min = currentDate.minute - date.minute;
      if (mm < 0) {
        yy--;
        mm += 12;
      }
      if (dd < 0) {
        mm--;
        dd += 30;
      }
      if (hh < 0) {
        dd--;
        hh += 24;
      }
      if (min < 0) {
        hh--;
        min += 60;
      }
      if (dd > 6) {
        str = DateFormat('dd MMM à HH:mm').format(date);
      } else {
        String ch = "";
        switch (dd) {
          case 0:
            if (hh > 0) {
              ch = "0$hh";
              ch = ch.substring(ch.length - 2);
              str = "Il y'a $ch heure(s)";
            } else {
              if (min > 0) {
                ch = "0$min";
                ch = ch.substring(ch.length - 2);
                str = "Il y'a $ch minute(s)";
              } else {
                str = "Il y a un instant";
              }
            }
            break;
          case 1:
            str = "Hier ${DateFormat('HH:mm').format(date)}";
            break;
          default:
            str = DateFormat('EEE à HH:mm').format(date);
            break;
        }
      }
    }
    return str;
  }

  static String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int yy = currentDate.year - birthDate.year;
    int mm = currentDate.month - birthDate.month;
    int dd = currentDate.day - birthDate.day;
    if (mm < 0) {
      yy--;
      mm += 12;
    }
    if (dd < 0) {
      mm--;
      dd += 30;
    }
    String age = "";
    if (yy > 1) {
      age = "$yy an(s)";
    } else {
      mm = yy * 12 + mm;
      if (mm > 0) {
        age = "$mm mois";
      } else if (dd > 0) {
        age = "$dd jours";
      }
    }
    return age;
  }

  static makeExternalRequest({required Uri uri}) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.path}';
    }
  }

  // static _drawerButton(
  //         {required String text,
  //         required IconData icon,
  //         required BuildContext context,
  //         required onTap,
  //         Color? backColor,
  //         Color? frontColor}) =>
  //     Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //         decoration: BoxDecoration(
  //             borderRadius: const BorderRadius.only(
  //                 bottomLeft: Radius.circular(20),
  //                 topRight: Radius.circular(20)),
  //             color: backColor ??
  //                 AppColor.lightColor[
  //                     Random().nextInt(AppColor.lightColor.length - 1) + 1]),
  //         child: InkWell(
  //             onTap: onTap,
  //             child: Ink(
  //                 child: FittedBox(
  //                     child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Icon(icon,
  //                                   size: 26,
  //                                   color: frontColor ?? AppColor.black),
  //                               const SizedBox(width: 10),
  //                               Text(text,
  //                                   style: Theme.of(context)
  //                                       .textTheme
  //                                       .bodyLarge!
  //                                       .copyWith(
  //                                           fontWeight: FontWeight.bold,
  //                                           color:
  //                                               frontColor ?? AppColor.black))
  //                             ]))))));

  static String extension({required String filename}) =>
      ".${filename.split(".").last}";

  static double getDouble(var m, String column) {
    try {
      return double.parse(m[column]);
    } catch (e) {
      return double.parse(m[column].toString());
    }
  }

  static int getInt(var m, String column) {
    try {
      return int.parse(m[column]);
    } catch (e) {
      return int.parse(m[column].toString());
    }
  }

  static reparerBDD({required bool showToast}) {
    String serverDir = getServerDirectory();
    var url = "$serverDir/REPARER_BDD.php";
    debugPrint(url);
    Uri myUri = Uri.parse(url);
    http.post(myUri, body: {}).then((response) async {
      if (response.statusCode == 200) {
        var result = response.body;
        if (result != "0") {
          if (showToast) {
            AppData.mySnackBar(
                title: 'Base de Données',
                message: "La base de données à été réparer ...",
                color: AppColor.green);
          }
        } else {
          if (showToast) {
            AppData.mySnackBar(
                title: 'Base de Données',
                message:
                    "Probleme lors de la réparation de la base de données !!!",
                color: AppColor.red);
          }
        }
      } else {
        if (showToast) {
          AppData.mySnackBar(
              title: 'Base de Données',
              message: "Probleme de Connexion avec le serveur 5!!!",
              color: AppColor.red);
        }
      }
    }).catchError((error) {
      debugPrint("erreur reparerBDD: $error");
      if (showToast) {
        AppData.mySnackBar(
            title: 'Base de Données',
            message: "Probleme de Connexion avec le serveur 6!!!",
            color: AppColor.red);
      }
    });
  }

  static logout({question = true}) {
    // String alert = '';
    // (User.isAdmin) //&& GestGalleryImages.myImages.isNotEmpty)
    //     ? alert =
    //         '\n Attention tous les chargement des images seront arrêter ....'
    //     : alert = '';
    // if (question) {
    //   AwesomeDialog(
    //           context: Get.context!,
    //           dialogType: DialogType.warning,
    //           title: 'Alerte',
    //           btnOkText: "Oui",
    //           btnCancelText: "Non",
    //           width: AppSizes.widthScreen,
    //           btnCancelOnPress: () {
    //             HomePageController hc = Get.find();
    //             if (hc.pageIndex == 7) {
    //               hc.changePage(hc.oldPage);
    //             }
    //           },
    //           onDismissCallback: (type) {
    //             HomePageController hc = Get.find();
    //             if (hc.pageIndex == 7) {
    //               hc.changePage(hc.oldPage);
    //             }
    //           },
    //           btnOkOnPress: () {
    //             _closeall(true);
    //           },
    //           showCloseIcon: true,
    //           desc: 'Voulez-vous vraiment déconnecter ??$alert')
    //       .show();
    // } else {
    //   _closeall(true);
    // }
  }

  static _closeall(bool erase) async {
    // if (erase) {
    //   SettingServices c = Get.find();
    //   c.sharedPrefs.setBool('CONNECTED', false);
    //   c.sharedPrefs.setString('KEY', '');
    //   c.sharedPrefs.setString('USERNAME', '');
    //   c.sharedPrefs.setString('PASSWORD', '');
    //   c.sharedPrefs.setString('EMAIL', '');
    // }
    // User.idUser = 0;
    // UserController userController = Get.find();
    // userController.enfants = [];

    // Get.delete<HomePageController>();
    // Get.delete<ListAnnonceController>();
    // Get.delete<ListEnfantsController>();
    // Get.delete<ListParentsController>();
    // Get.delete<ListEnseignantsController>();
    // Get.delete<ListAlbumsController>();
    // Get.delete<ListSectionsController>();
    // Get.delete<ListMessagesController>();
    // Get.delete<LoginController>();

    // Get.offAllNamed(AppRoute.login);
  }

  static versionOutDated() {
    if (!outdatedVersion) {
      outdatedVersion = true;
      AppData.mySnackBar(
          title: 'Application',
          message: "Veuillez installer la nouvelle version de l'application",
          color: AppColor.red);
      Get.toNamed(AppRoute.outDate);
    }
  }

  // static Drawer myDrawer(BuildContext context, {Color? color}) => Drawer(
  //     child: Container(
  //         decoration: const BoxDecoration(),
  //         //      image: DecorationImage(
  //         //         image: AssetImage(AppImageAsset.wallLogin),
  //         //        fit: BoxFit.cover)),
  //         padding: const EdgeInsets.only(bottom: 10),
  //         child: ListView(children: [
  //           Container(
  //               margin: const EdgeInsets.only(top: 10),
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                         padding: const EdgeInsets.only(left: 10, top: 10),
  //                         child: Text("Hi",
  //                             style: Theme.of(context).textTheme.displayLarge)),
  //                     Center(
  //                         child: Wrap(children: [
  //                       Text(User.isAdmin ? "Administrateur" : User.name,
  //                           textAlign: TextAlign.center,
  //                           style: Theme.of(context).textTheme.displayLarge)
  //                     ]))
  //                   ])),
  //           const Divider(color: AppColor.black),
  //           _drawerButton(
  //               backColor: AppColor.annonce,
  //               frontColor: AppColor.white,
  //               icon: Icons.announcement_outlined,
  //               context: context,
  //               onTap: () {
  //                 Get.back();
  //                 Get.toNamed(AppRoute.listAnnonces);
  //               },
  //               text: "Liste des Annonces"),
  //           _drawerButton(
  //               backColor: AppColor.message,
  //               frontColor: AppColor.white,
  //               icon: AppIcon.sms,
  //               context: context,
  //               onTap: () {
  //                 Get.back();
  //                 Get.toNamed(AppRoute.listMessages);
  //               },
  //               text: "Liste des Messages"),
  //           _drawerButton(
  //               backColor: AppColor.gallery,
  //               frontColor: AppColor.white,
  //               icon: Icons.photo,
  //               context: context,
  //               onTap: () {
  //                 Get.back();
  //                 Get.toNamed(AppRoute.listAlbum);
  //               },
  //               text: "Liste des Albums"),
  //           const SizedBox(height: 25),
  //           if (User.isAdmin)
  //             _drawerButton(
  //                 backColor: AppColor.enfant,
  //                 frontColor: AppColor.white,
  //                 icon: AppIcon.enfant,
  //                 context: context,
  //                 onTap: () {
  //                   Get.back();
  //                   Get.toNamed(AppRoute.listEnfants);
  //                 },
  //                 text: "Liste des Enfants"),
  //           if (User.isAdmin)
  //             _drawerButton(
  //                 backColor: AppColor.parent,
  //                 frontColor: AppColor.white,
  //                 icon: AppIcon.parent,
  //                 context: context,
  //                 onTap: () {
  //                   Get.back();
  //                   Get.toNamed(AppRoute.listParents);
  //                 },
  //                 text: "Liste des Parents"),
  //           if (User.isAdmin)
  //             _drawerButton(
  //                 backColor: AppColor.section,
  //                 frontColor: AppColor.white,
  //                 icon: Icons.groups_outlined,
  //                 context: context,
  //                 onTap: () {
  //                   Get.back();
  //                   Get.toNamed(AppRoute.listSections);
  //                 },
  //                 text: "Liste des Sections"),
  //           if (User.isAdmin)
  //             _drawerButton(
  //                 backColor: AppColor.enseignant,
  //                 frontColor: AppColor.white,
  //                 icon: Icons.person_pin_outlined,
  //                 context: context,
  //                 onTap: () {
  //                   Get.back();
  //                   Get.toNamed(AppRoute.listEnseignants);
  //                 },
  //                 text: "Liste des Enseigants"),
  //           const SizedBox(height: 25),
  //           if (User.isAdmin)
  //             _drawerButton(
  //                 backColor: AppColor.blue1,
  //                 frontColor: AppColor.white,
  //                 context: context,
  //                 icon: Icons.verified_user_outlined,
  //                 onTap: () {
  //                   Get.back();
  //                   // Get.to(() => const FicheCompteAdmin());
  //                 },
  //                 text: "Compte Administrateur"),
  //           if (User.isAdmin)
  //             _drawerButton(
  //                 backColor: AppColor.black,
  //                 frontColor: AppColor.white,
  //                 context: context,
  //                 icon: Icons.settings,
  //                 onTap: () {
  //                   Get.back();
  //                   reparerBDD(showToast: true);
  //                 },
  //                 text: "Réparer La Base de données"),
  //           _drawerButton(
  //               backColor: AppColor.red,
  //               frontColor: AppColor.white,
  //               context: context,
  //               icon: Icons.logout,
  //               onTap: () {
  //                 logout();
  //               },
  //               text: "Déconnecter"),
  //           if (User.isParent) const Divider(color: AppColor.black),
  //           if (User.isParent) const SizedBox(height: 25),
  //           // if (User.isParent)
  //           // GetBuilder<UserController>(
  //           //     builder: (controller) => Visibility(
  //           //         visible: controller.loading,
  //           //         replacement: Center(
  //           //             child: Text(
  //           //                 controller.enfants.isEmpty
  //           //                     ? "Aucun Enfant"
  //           //                     : "Liste des Enfants",
  //           //                 style: Theme.of(context)
  //           //                     .textTheme
  //           //                     .bodyLarge!
  //           //                     .copyWith(
  //           //                         decoration: TextDecoration.underline,
  //           //                         fontWeight: FontWeight.bold))),
  //           //         child: const LoadingWidget())),
  //           // if (User.isParent) const ListOfEnfantDrawer()
  //         ])));

  static connecter() {
    String serverDir = getServerDirectory();
    var url = "$serverDir/TEST_INTERNET.php";
    debugPrint("------ test internet ------------ url=$url");
    Uri myUri = Uri.parse(url);
    http
        .post(myUri, body: {})
        .timeout(getTimeOut())
        .then((response) async {
          if (response.statusCode == 200) {
            _closeall(false);
          } else {
            Timer(const Duration(seconds: 5), connecter);
          }
        })
        .catchError((error) {
          Timer(const Duration(seconds: 5), connecter);
        });
  }

  static openPlayStorePgae() {
    // const url = 'https://play.google.com/store/apps/details?id=com.bouledrouaamor.atlas_school';
    //  AppData.makeExternalRequest(uri: Uri.parse(url));
    LaunchReview.launch(androidAppId: 'com.bouledrouaamor.atlas_school');
  }
}
