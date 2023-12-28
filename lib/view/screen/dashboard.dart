import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/rdv_controller.dart';
import '../../core/constant/image_asset.dart';
import '../widget/dashboard/header_dashboard_widget.dart';
import '../widget/dashboard/list_rdv_dashboard.dart';
import '../widget/dashboard/workspace_dashboard.dart';
import '../widget/mywidget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RDVController());
    Get.put(DashBoardController());
    return MyWidget(
        blurBackground: true,
        backgroudImage: AppImageAsset.wall,
        child: Column(children: [
          const SizedBox(height: 45, child: HeaderDashBoardWidget()),
          Expanded(
              child: Row(children: [
            const Expanded(child: WorkSpaceDashBoard()),
            GetBuilder<DashBoardController>(
                builder: (controller) => AnimatedCrossFade(
                    duration: const Duration(milliseconds: 1700),
                    firstChild:
                        const SizedBox(width: 200, child: ListRdvDashBoard()),
                    secondChild: SizedBox(
                        width: 20,
                        child: Column(children: [
                          InkWell(
                              onTap: () {
                                DashBoardController controller = Get.find();
                                controller.updateShowListeRDv();
                              },
                              child: Ink(
                                  child: const Icon(Icons.arrow_back_rounded)))
                        ])),
                    crossFadeState: controller.showListRdv
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond))
          ]))
        ]));
  }
}
