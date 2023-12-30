import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../core/constant/color.dart';
import '../../screen/acceuil_page.dart';

class WorkSpaceDashBoard extends StatelessWidget {
  const WorkSpaceDashBoard({super.key});

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(color: AppColor.white),
      child: GetBuilder<DashBoardController>(
          builder: (controller) => controller.indexPage == 1
              ? const PageAcceuil()
              : controller.indexPage == 2
                  ? const Text('Consultation')
                  : controller.indexPage == 3
                      ? const Text('Rendez-vous')
                      : controller.indexPage == 4
                          ? const Text('Patient')
                          : const Text('Parametres')));

  // listRdvWidget() => GetBuilder<DashBoardController>(
  //     builder: (controller) => AnimatedCrossFade(
  //         duration: const Duration(milliseconds: 1700),
  //         firstChild: const SizedBox(width: 200, child: ListRdvDashBoard()),
  //         secondChild: SizedBox(
  //             width: 20,
  //             child: Column(children: [
  //               InkWell(
  //                   onTap: () {
  //                     DashBoardController controller = Get.find();
  //                     controller.updateShowListeRDv();
  //                   },
  //                   child: Ink(child: const Icon(Icons.arrow_back_rounded)))
  //             ])),
  //         crossFadeState: controller.showListRdv
  //             ? CrossFadeState.showFirst
  // : CrossFadeState.showSecond));
}
