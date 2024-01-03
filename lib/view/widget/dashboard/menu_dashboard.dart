import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/acceuil_controller.dart';
import '../../../controller/dashboard_controller.dart';
import '../../../core/class/user.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';

class MenuDashBoardWidget extends StatelessWidget {
  const MenuDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    // debugPrint(AppSizes.widthScreen.toString());
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 100, child: Lottie.asset(AppAnimationAsset.heart)),
          FittedBox(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(User.cabinet,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontFamily: fontFamily)))),
          FittedBox(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(User.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontFamily: fontFamily)))),
          const SizedBox(height: 5),
          const Divider(endIndent: 50, indent: 50),
          const SizedBox(height: 5),
          if (AppSizes.heightScreen > 283)
            myButton(
                icon: Icons.space_dashboard_outlined,
                text: "Acceuil",
                myIndex: 1,
                onTap: () {
                  if (Get.isRegistered<AcceuilController>()) {
                    Get.delete<AcceuilController>();
                  }
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 1);
                }),
          if (AppSizes.heightScreen > 333)
            myButton(
                icon: Icons.content_paste_search_rounded,
                text: "Consultation",
                myIndex: 2,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 2);
                }),
          if (AppSizes.heightScreen > 383)
            myButton(
                icon: Icons.date_range_outlined,
                text: "Rendez-vous",
                myIndex: 3,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 3);
                }),
          if (AppSizes.heightScreen > 433)
            myButton(
                icon: Icons.person_pin_outlined,
                text: "Patients",
                myIndex: 4,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 4);
                }),
          if (AppSizes.heightScreen > 483)
            myButton(
                icon: Icons.settings_applications_outlined,
                text: "Parametres",
                myIndex: 5,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 5);
                }),
          const Spacer(),
          myButton(
              icon: Icons.logout,
              text: "Déconnecter",
              myIndex: 6,
              logout: true,
              onTap: () async {
                DashBoardController controller = Get.find();
                controller.updateLogout(value: true);
                await AppData.logout()
                    .then((value) => controller.updateLogout(value: false));
              })
        ]);
  }

  myButton(
          {required String text,
          required IconData icon,
          bool logout = false,
          required int myIndex,
          Function()? onTap}) =>
      GetBuilder<DashBoardController>(
          builder: (controller) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: controller.indexPage == myIndex
                      ? const Color.fromARGB(255, 12, 151, 17)
                      : logout && controller.logout
                          ? AppColor.red
                          : Colors.transparent,
                  border: Border(
                      left: BorderSide(
                          width: 5,
                          color: controller.indexPage == myIndex
                              ? AppColor.primary
                              : logout
                                  ? (controller.logout
                                      ? AppColor.primary
                                      : AppColor.red)
                                  : AppColor.grey))),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: InkWell(
                  onTap: onTap,
                  child: Ink(
                      child: Row(children: [
                    Icon(icon,
                        color: controller.indexPage == myIndex ||
                                (controller.logout && logout)
                            ? AppColor.white
                            : AppColor.black),
                    const SizedBox(width: 15),
                    Text(text,
                        style: TextStyle(
                            fontSize: controller.indexPage == myIndex ||
                                    (controller.logout && logout)
                                ? 16
                                : 14,
                            fontFamily: fontFamily,
                            color: controller.indexPage == myIndex ||
                                    (controller.logout && logout)
                                ? AppColor.white
                                : AppColor.black))
                  ])))));
}
