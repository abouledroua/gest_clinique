import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/theme.dart';

class MenuDashBoardWidget extends StatelessWidget {
  const MenuDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DashBoardController controller = Get.find();
    return Container(
        height: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 100, child: Image.asset(AppImageAsset.logo)),
              Text('Gestion Cabinet Médical',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontFamily: fontFamily)),
              const SizedBox(height: 30),
              myButton(
                  icon: Icons.home,
                  text: "Acceuil",
                  myIndex: 1,
                  onTap: () {
                    controller.updateIndexPage(index: 1);
                  }),
              myButton(
                  icon: Icons.date_range_outlined,
                  text: "Rendez-vous",
                  myIndex: 2,
                  onTap: () {
                    controller.updateIndexPage(index: 2);
                  }),
              myButton(
                  icon: Icons.content_paste_search_rounded,
                  text: "Consultation",
                  myIndex: 3,
                  onTap: () {
                    controller.updateIndexPage(index: 3);
                  }),
              myButton(
                  icon: Icons.person_pin_outlined,
                  text: "Patients",
                  myIndex: 4,
                  onTap: () {
                    controller.updateIndexPage(index: 4);
                  }),
              myButton(
                  icon: Icons.settings_applications_outlined,
                  text: "Parametres",
                  myIndex: 5,
                  onTap: () {
                    controller.updateIndexPage(index: 5);
                  }),
              const Spacer(),
              myButton(
                  icon: Icons.logout,
                  text: "Déconnecter",
                  myIndex: 6,
                  onTap: () {
                    controller.updateIndexPage(index: 6);
                  }),
            ]));
  }

  myButton(
          {required String text,
          required IconData icon,
          required int myIndex,
          Function()? onTap}) =>
      GetBuilder<DashBoardController>(
          builder: (controller) => Container(
              width: double.infinity,
              color: controller.indexPage == myIndex
                  ? AppColor.white
                  : Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: InkWell(
                  onTap: onTap,
                  child: Ink(
                      child: Row(children: [
                    Icon(icon,
                        color: controller.indexPage == myIndex
                            ? AppColor.green
                            : AppColor.black),
                    const SizedBox(width: 5),
                    Text(text,
                        style: TextStyle(
                            fontSize: controller.indexPage == myIndex ? 20 : 18,
                            fontFamily: fontFamily,
                            color: controller.indexPage == myIndex
                                ? AppColor.green
                                : AppColor.black,
                            fontWeight: controller.indexPage == myIndex
                                ? FontWeight.bold
                                : FontWeight.normal))
                  ])))));
}
