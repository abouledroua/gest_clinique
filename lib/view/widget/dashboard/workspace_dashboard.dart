import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../core/class/user.dart';
import '../../../core/constant/color.dart';
import 'footer_dashboard_widget.dart';
import 'header_dashboard_widget.dart';
import 'list_rdv_dashboard.dart';

class WorkSpaceDashBoard extends StatelessWidget {
  const WorkSpaceDashBoard({super.key});

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(color: AppColor.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            height: 80,
            child: Column(children: [
              const HeaderDashBoardWidget(),
              Text('Bienvenue ${User.name}')
            ])),
        const Spacer(),
        const SizedBox(height: 45, child: FooterDashBoardWidget())
      ]));

  GetBuilder<DashBoardController> listRdvWidget() =>
      GetBuilder<DashBoardController>(
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
