import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../core/constant/color.dart';
import '../../screen/acceuil_page.dart';
import '../../screen/list_rdv_page.dart';

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
                      ? const ListRdvPage()
                      : controller.indexPage == 4
                          ? const Text('Patient')
                          : const Text('Parametres')));
}
