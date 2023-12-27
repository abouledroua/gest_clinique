import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/rdv_controller.dart';
import '../../core/constant/image_asset.dart';
import '../widget/dashboard/list_rdv_dashboard.dart';
import '../widget/mywidget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RDVController());
    Get.put(DashBoardController());
    return const MyWidget(
        blurBackground: true,
        backgroudImage: AppImageAsset.wall,
        child: Row(children: [
          Expanded(flex: 7, child: Column(children: [Text('s')])),
          Expanded(flex: 2, child: ListRdvDashBoard())
        ]));
  }
}
