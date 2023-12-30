import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/rdv_controller.dart';
import '../../core/class/user.dart';
import '../../core/constant/animation_asset.dart';
import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';
import '../../core/constant/theme.dart';
import '../widget/dashboard/list_rdv_dashboard.dart';

class PageAcceuil extends StatelessWidget {
  const PageAcceuil({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    return Row(children: [
      Expanded(
          child:
              ListView(children: [const SizedBox(height: 30), colorTitle()])),
      if (AppSizes.widthScreen > 950) listRdvWidget()
    ]);
  }

  colorTitle() => Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: User.sexe == 1
                  ? const [
                      Color.fromARGB(255, 38, 118, 183),
                      Color.fromARGB(255, 4, 67, 119)
                    ]
                  : const [
                      Color.fromARGB(255, 204, 85, 125),
                      Color.fromARGB(255, 141, 1, 47)
                    ])),
      child: Stack(children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text('Welcome back',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: fontFamily,
                      color: AppColor.white)),
              Text(User.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: fontFamily,
                      color: AppColor.white)),
              Row(children: [
                Text("Vous avez au total ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: fontFamily,
                        color: AppColor.white)),
                GetBuilder<RDVController>(
                    builder: (controller) => Text(
                        "${controller.rdvs.length} rendez-vous",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamily,
                            color: Colors.yellow))),
                Text(" aujourdh'ui",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: fontFamily,
                        color: AppColor.white))
              ]),
              const SizedBox(height: 10)
            ]),
        Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: SizedBox(
                width: AppSizes.heightScreen / 3,
                child: Visibility(
                    visible: User.sexe == 2,
                    replacement: Lottie.asset(AppAnimationAsset.nurse),
                    child: Lottie.asset(AppAnimationAsset.doctor))))
      ]));

  listRdvWidget() => GetBuilder<DashBoardController>(
      builder: (controller) => AnimatedCrossFade(
          duration: const Duration(milliseconds: 1700),
          firstChild: const SizedBox(width: 200, child: ListRdvDashBoard()),
          secondChild: SizedBox(
              width: 20,
              child: Column(children: [
                InkWell(
                    onTap: () {
                      DashBoardController controller = Get.find();
                      controller.updateShowListeRDv();
                    },
                    child: Ink(child: const Icon(Icons.arrow_back_rounded)))
              ])),
          crossFadeState: controller.showListRdv
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond));
}
