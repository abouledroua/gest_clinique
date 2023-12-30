import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';

class HeaderDashBoardWidget extends StatelessWidget {
  const HeaderDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    return Row(children: [
      const SizedBox(width: 10),
      GetBuilder<DashBoardController>(
          builder: (controller) => Text(
              controller.indexPage == 1
                  ? 'Acceuil'
                  : controller.indexPage == 2
                      ? 'Consultation'
                      : controller.indexPage == 3
                          ? 'Rendez-vous'
                          : controller.indexPage == 4
                              ? 'Patient'
                              : 'Parametres',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamily,
                  color: AppColor.black))),
      const Spacer(),
      if (AppSizes.widthScreen > 650) searchBar(),
      const SizedBox(width: 30),
      headerIcons()
    ]);
  }

  headerIcons() => Row(children: [
        Image.asset(AppImageAsset.noPhoto),
        const SizedBox(width: 10),
        Tooltip(
            message: 'Déconnecter',
            child: InkWell(
                onTap: () {
                  AppData.logout();
                },
                child: Ink(child: Lottie.asset(AppAnimationAsset.logout))))
      ]);

  searchBar() => GetBuilder<DashBoardController>(
      builder: (controller) => Visibility(
          visible: controller.indexPage != 4,
          child: InkWell(
              onTap: () {
                DashBoardController controller = Get.find();
                controller.updateIndexPage(index: 4);
              },
              child: Ink(
                  child: Card(
                      elevation: 5,
                      child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 229, 226, 226),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 142, 137, 137))),
                          width: 200,
                          child: Row(children: [
                            const Icon(Icons.search_rounded,
                                size: 22,
                                color: Color.fromARGB(255, 104, 101, 101)),
                            const SizedBox(width: 10),
                            Text('Rechercher un Patient',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: fontFamily,
                                    color: const Color.fromARGB(
                                        255, 104, 101, 101)))
                          ])))))));
}
