import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/patient_controller.dart';
import '../../controller/rdv_controller.dart';
import '../../core/constant/data.dart';
import '../../core/constant/sizes.dart';
import '../../main.dart';
import '../widget/dashboard/header_dashboard_widget.dart';
import '../widget/dashboard/menu_dashboard.dart';
import '../widget/dashboard/workspace_dashboard.dart';
import '../widget/mywidget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    if (!AppData.isConnected()) {
      AppData.logout(question: false);
    }
    Get.put(PatientController());
    Get.put(RDVController());
    Get.put(DashBoardController());
    return MyWidget(
        gradient: myBackGradient,
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppSizes.widthScreen / 70,
                vertical: AppSizes.heightScreen / 50),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(children: [
              Container(
                  decoration: const BoxDecoration(color: Colors.white70),
                  child:
                      const SizedBox(width: 160, child: MenuDashBoardWidget())),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: const Column(children: [
                        SizedBox(height: 45, child: HeaderDashBoardWidget()),
                        Expanded(child: WorkSpaceDashBoard())
                      ])))
            ])));
  }
}
