// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../view/screen/fichemessage.dart';
// import 'class/user.dart';
// import 'constant/color.dart';
// import 'constant/data.dart';
// import 'constant/routes.dart';

// initNotification() {
//   debugPrint('initNotification ....');
//   AwesomeNotifications().initialize(
//       'resource://drawable/icone',
//       [
//         NotificationChannel(
//             channelKey: 'msg_channel',
//             channelName: 'Message notifications',
//             channelDescription:
//                 'Notification channel for receiving new message',
//             defaultColor: Colors.green.shade600,
//             importance: NotificationImportance.High,
//             channelShowBadge: true,
//             playSound: true,
//             icon: 'resource://drawable/icone',
//             soundSource: 'resource://raw/res_sms',
//             ledColor: Colors.white,
//             onlyAlertOnce: true,
//             defaultPrivacy: NotificationPrivacy.Private,
//             vibrationPattern: lowVibrationPattern),
//         NotificationChannel(
//             channelKey: 'update_channel',
//             channelName: 'Mise à jours notifications',
//             channelDescription: 'Notification channel for detecting new update',
//             defaultColor: AppColor.purple,
//             importance: NotificationImportance.High,
//             playSound: true,
//             icon: 'resource://drawable/icone',
//             soundSource: 'resource://raw/res_announce',
//             ledColor: Colors.white,
//             onlyAlertOnce: true,
//             defaultPrivacy: NotificationPrivacy.Private,
//             vibrationPattern: lowVibrationPattern),
//         NotificationChannel(
//             channelKey: 'upload_Image_channel',
//             channelName: 'Upload Image notifications',
//             channelDescription: 'Notification channel for uploading images',
//             defaultColor: Colors.amber,
//             importance: NotificationImportance.High,
//             icon: 'resource://drawable/icone',
//             channelShowBadge: true,
//             playSound: true,
//             soundSource: 'resource://raw/res_upload',
//             onlyAlertOnce: true,
//             ledColor: Colors.yellow),
//         NotificationChannel(
//             channelKey: 'annonce_channel',
//             channelName: 'Annonce notifications',
//             channelDescription:
//                 'Notification channel for alerts about new announce',
//             defaultColor: Colors.indigo,
//             importance: NotificationImportance.High,
//             channelShowBadge: true,
//             playSound: true,
//             icon: 'resource://drawable/icone',
//             soundSource: 'resource://raw/res_announce',
//             defaultPrivacy: NotificationPrivacy.Private,
//             ledColor: AppColor.blue1)
//       ],
//       debug: true);

//   // AwesomeNotifications().actionStream.listen((event) {
//   //   debugPrint("actionStream=${event.channelKey}");
//   //   switch (event.channelKey) {
//   //     case "msg_channel":
//   //       if (User.isAdmin) {
//   //         Get.toNamed(AppRoute.listMessages);
//   //       } else {
//   //         Get.to(() => FicheMessage(idUser: 1, parentName: User.name));
//   //       }
//   //       break;
//   //     case "annonce_channel":
//   //       Get.toNamed(AppRoute.listAnnonces);
//   //       break;
//   //     case "update_channel":
//   //       AppData.openPlayStorePgae();
//   //       break;
//   //     default:
//   //   }
//   // });
// }
