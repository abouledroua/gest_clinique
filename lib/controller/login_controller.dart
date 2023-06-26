// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import '../core/class/user.dart';
// import '../core/constant/color.dart';
// import '../core/constant/data.dart';
// import '../core/constant/sizes.dart';

// class LoginController extends GetxController {
//   late TextEditingController userController, passController, tokenController;
//   String erreur = "";
//   int type = 0;
//   bool valider = false, wrongCredent = false, erreurServeur = false;

//   Future<bool> onWillPop() async =>
//       (await showDialog(
//           context: Get.context!,
//           builder: (context) => AlertDialog(
//                   title: Row(children: [
//                     Icon(Icons.exit_to_app_sharp, color: AppColor.red),
//                     const Padding(
//                         padding: EdgeInsets.only(left: 8.0),
//                         child: Text('Etes-vous sur ?'))
//                   ]),
//                   content: const Text(
//                       "Voulez-vous vraiment quitter l'application ?"),
//                   actions: <Widget>[
//                     TextButton(
//                         onPressed: () => Get.back(result: false),
//                         child:
//                             Text('Non', style: TextStyle(color: AppColor.red))),
//                     TextButton(
//                         onPressed: () => Get.back(result: true),
//                         child: Text('Oui',
//                             style: TextStyle(color: AppColor.green)))
//                   ]))) ??
//       false;

//   setValider(pValue) {
//     valider = pValue;
//     update();
//   }

//   updateType(int value) {
//     type = value;
//     update();
//   }

//   onValidate() {
//     setValider(true);
//     if (kDebugMode || AppData.testMode) {
//       print("valider=$valider");
//     }
//     String serverDir = AppData.getServerDirectory();
//     var url = "$serverDir/EXIST_USER.php";
//     //if (kDebugMode || AppData.testMode) {
//     print("url=$url");
//     //}
//     String userName = userController.text.toUpperCase();
//     String password = passController.text.toUpperCase();
//     Uri myUri = Uri.parse(url);
//     http
//         .post(myUri, body: {"USERNAME": userName, "PASSWORD": password})
//         .timeout(AppData.getTimeOut())
//         .then((response) async {
//           if (response.statusCode == 200) {
//             print("responsebody=${response.body}");
//             print("response=${response.toString()}");
//             erreurServeur = false;
//             wrongCredent = false;
//             erreur = "";
//             var responsebody = jsonDecode(response.body);
//             User.idUser = 0;
//             int etat = 0;
//             for (var m in responsebody) {
//               etat = int.parse(m['ETAT']);
//               if (etat == 1) {
//                 createVarUser(
//                     etat: etat,
//                     idGroupe: int.parse(m['ID_GROUPE']),
//                     idUser: int.parse(m['ID_USER']),
//                     name: m['NAME'],
//                     password: password,
//                     type: int.parse(m['TYPE']),
//                     userName: userName);
//               }
//             }
//             if (User.idUser == 0 || etat == 2) {
//               effacerLastUser();
//               String msg = (etat == 2)
//                   ? "Vous devez contacter l'administration de l'ecole pour confirmer ce compte !!!!"
//                   : "Nom d' 'utilisateur ou mot de passe invalide !!!";
//               wrongCredent = true;
//               if (kDebugMode || AppData.testMode) {
//                 print(msg);
//               }
//               setValider(false);
//               AppData.mySnackBar(
//                   title: 'Login',
//                   message: msg,
//                   color: (etat == 2) ? AppColor.purple : AppColor.red);
//             } else if (etat == 1) {
//               userVerified(
//                   userName: userName, password: password, modeLogin: 1);
//             } else {
//               //tryConnectedBefore();
//               effacerLastUser();
//               AppData.mySnackBar(
//                   title: 'Login',
//                   message:
//                       "Utilisateur inactif !!! \nVeuillez contacter l'administration ...",
//                   color: AppColor.red);
//               if (kDebugMode || AppData.testMode) {
//                 print(
//                     "Utilisateur inactif !!! \nVeuillez contacter l'administration ...");
//               }
//               setValider(false);
//               if (kDebugMode || AppData.testMode) {
//                 print("etat = ${User.etat}");
//               }
//             }
//           } else {
//             // tryConnectedBefore();
//             // effacerLastUser();
//             erreur = " seurveur 1";
//             erreurServeur = true;
//             AppData.mySnackBar(
//                 title: 'Login',
//                 message: "Probleme lors de la connexion avec le serveur !!!",
//                 color: AppColor.red);
//             if (kDebugMode || AppData.testMode) {
//               print("Probleme lors de la connexion avec le serveur !!!");
//             }
//             setValider(false);
//           }
//         })
//         .catchError((error) {
//           // tryConnectedBefore();
//           // effacerLastUser();
//           //AppData.mySnackBar(              title: 'Login',              message: "Probleme de Connexion avec le serveur 33 !!!",                        color: AppColor.red);
//           erreur = error;
//           erreurServeur = true;
//           if (kDebugMode || AppData.testMode) {
//             print("erreur onValidate: $error");
//           }
//           if (kDebugMode || AppData.testMode) {
//             print("Probleme de Connexion avec le serveur 33 !!!");
//           }
//           setValider(false);
//           if (kDebugMode || AppData.testMode) {
//             print("error : ${error.toString()}");
//           }
//         });
//   }

//   createVarUser(
//       {required int idUser,
//       required String name,
//       required int etat,
//       required int idGroupe,
//       required int type,
//       required String userName,
//       required String password}) {
//     User.idUser = idUser;
//     User.name = name;
//     User.etat = etat;
//     User.idGroupe = idGroupe;
//     User.type = type;
//     User.username = userName;
//     User.password = password;
//     User.isAdmin = (User.type == 2);
//   }

//   userVerified(
//       {required String userName,
//       required String password,
//       required modeLogin}) async {
//     if (kDebugMode || AppData.testMode) {
//       print("Its Ok ----- Connected ----------------");
//     }
//     AppData.modeLogin = modeLogin;
//     if (AppData.modeLogin == 0) {
//       AppData.connecter();
//     }
//     SettingServices c = Get.find();
//     c.sharedPrefs.setString('LastUser', userName);
//     c.sharedPrefs.setString('LastPass', password);
//     c.sharedPrefs.setBool('LastConnected', true);
//     String privacy = c.sharedPrefs.getString('Privacy${User.idUser}') ?? "";
//     userController.text = "";
//     passController.text = "";
//     valider = false;
//     if (privacy.isEmpty) {
//       print("Going to Privacy");
//       Get.toNamed(AppRoute.privacy)
//           ?.then((value) => Get.offAllNamed(AppRoute.homePage));
//     } else {
//       Get.offAllNamed(AppRoute.homePage);
//     }
//   }

//   @override
//   void onInit() {
//     WidgetsFlutterBinding.ensureInitialized();
//     initConnect();
//     super.onInit();
//   }

//   initConnect() {
//     AppSizes.setSizeScreen(Get.context);
//     type = 0;
//     //Get.reset();
//     userController = TextEditingController();
//     passController = TextEditingController();
//     tokenController = TextEditingController();
//     erreurServeur = false;
//     wrongCredent = false;
//     SettingServices c = Get.find();
//     //effacerLastUser();
//     String userPref = c.sharedPrefs.getString('LastUser') ?? "";
//     String passPref = c.sharedPrefs.getString('LastPass') ?? "";
//     bool connect = c.sharedPrefs.getBool('LastConnected') ?? false;
//     if (userPref.isNotEmpty && connect) {
//       userController.text = userPref;
//       passController.text = passPref;
//       onValidate();
//     }
//   }

//   effacerLastUser() {
//     SettingServices c = Get.find();
//     c.sharedPrefs.setString('LastUser', "");
//     c.sharedPrefs.setString('LastPass', "");
//     c.sharedPrefs.setBool('LastConnected', false);
//   }

//   @override
//   void onClose() {
//     userController.dispose();
//     passController.dispose();
//     tokenController.dispose();
//     super.onClose();
//   }

//   onValidateToken() {
//     if (tokenController.text.isEmpty) {
//       AppData.mySnackBar(
//           title: 'Token', message: 'Token Vide !!!', color: AppColor.red);
//       return;
//     }
//     if (tokenController.text == '4qQu3zv68Ev94vf' ||
//         (kDebugMode && tokenController.text == 'aa')) {
//       //'4qQu3zv68Ev94vf'
//       //admin
//       createVarUser(
//           idUser: 1,
//           name: '',
//           etat: 1,
//           idGroupe: 0,
//           type: 2,
//           userName: 'ADMIN',
//           password: 'ADMIN');
//       userVerified(userName: 'ADMIN', password: 'ADMIN', modeLogin: 1);
//     } else if (tokenController.text == 'eFXlCbSyubDN1qu' ||
//         (kDebugMode && tokenController.text == 'uu')) {
//       //'eFXlCbSyubDN1qu'
//       //user
//       createVarUser(
//           idUser: 2,
//           name: 'USER',
//           etat: 1,
//           idGroupe: 1,
//           type: 1,
//           userName: 'USER',
//           password: 'USER');
//       userVerified(userName: 'USER', password: 'USER', modeLogin: 1);
//     } else {
//       // wrong token
//       AppData.mySnackBar(
//           title: 'Token', message: 'Token eroné !!!', color: AppColor.red);
//       return;
//     }
//   }
// }
