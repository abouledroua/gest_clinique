import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../core/class/user.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/theme.dart';

class MenuDashBoardWidget extends StatelessWidget {
  const MenuDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                height: 100, child: Lottie.asset(AppAnimationAsset.hospital)),
            FittedBox(
                child: Text(User.organisation,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontFamily: fontFamily))),
            const SizedBox(height: 5),
            const Divider(endIndent: 50, indent: 50),
            const SizedBox(height: 5),
            myButton(
                icon: Icons.space_dashboard_outlined,
                text: "Acceuil",
                myIndex: 1,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 1);
                }),
            myButton(
                icon: Icons.content_paste_search_rounded,
                text: "Consultation",
                myIndex: 2,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 2);
                }),
            myButton(
                icon: Icons.date_range_outlined,
                text: "Rendez-vous",
                myIndex: 3,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 3);
                }),
            myButton(
                icon: Icons.person_pin_outlined,
                text: "Patients",
                myIndex: 4,
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateIndexPage(index: 4);
                }),
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
                onTap: () async {
                  DashBoardController controller = Get.find();
                  int old = controller.indexPage;
                  controller.updateIndexPage(index: 6);
                  await AppData.logout()
                      .then((value) => controller.updateIndexPage(index: old));
                }),
          ]);

  myButton(
          {required String text,
          required IconData icon,
          required int myIndex,
          Function()? onTap}) =>
      GetBuilder<DashBoardController>(
          builder: (controller) => Container(
              width: double.infinity,
              color: controller.indexPage == myIndex
                  ? myIndex == 6
                      ? AppColor.red
                      : const Color.fromARGB(255, 12, 151, 17)
                  : Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: InkWell(
                  onTap: onTap,
                  child: Ink(
                      child: Row(children: [
                    Icon(icon,
                        color: controller.indexPage == myIndex
                            ? AppColor.white
                            : AppColor.black),
                    const SizedBox(width: 15),
                    Text(text,
                        style: TextStyle(
                            fontSize: controller.indexPage == myIndex ? 20 : 18,
                            fontFamily: fontFamily,
                            color: controller.indexPage == myIndex
                                ? AppColor.white
                                : AppColor.black))
                  ])))));
}
