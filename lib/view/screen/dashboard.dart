import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/rdv_controller.dart';
import '../../core/constant/data.dart';
import '../../core/constant/sizes.dart';
import '../widget/dashboard/menu_dashboard.dart';
import '../widget/dashboard/workspace_dashboard.dart';
import '../widget/mywidget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!AppData.isConnected()) {
      AppData.logout(question: false);
    }
    Get.put(RDVController());
    Get.put(DashBoardController());
    return MyWidget(
        gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(255, 22, 175, 101),
              Color.fromARGB(255, 154, 206, 182)
            ]),
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppSizes.widthScreen / 50,
                vertical: AppSizes.heightScreen / 30),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(children: [
              Container(
                  decoration: const BoxDecoration(color: Colors.white70),
                  child:
                      const SizedBox(width: 200, child: MenuDashBoardWidget())),
              Expanded(
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const WorkSpaceDashBoard()))
            ])));
  }
}
