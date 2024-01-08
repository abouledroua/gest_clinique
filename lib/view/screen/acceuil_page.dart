import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gest_clinique/main.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/acceuil_controller.dart';
import '../../controller/acceuil_rapport_patient_controller.dart';
import '../../controller/acceuil_sexe_chart_controller.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/rdv_controller.dart';
import '../../core/class/user.dart';
import '../../core/constant/animation_asset.dart';
import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';
import '../../core/constant/theme.dart';
import '../widget/dashboard/list_rdv_dashboard.dart';
import '../widget/acceuil/patient_rapport_line_chart.dart';
import '../widget/login_register/connect_widget.dart';

class PageAcceuil extends StatelessWidget {
  const PageAcceuil({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    Get.put(AcceuilController());
    Get.put(AcceuilRapportPatientController());
    Get.put(AcceuilSexeChartController());
    return Row(children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(Get.context!).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse
                      }),
                  child: ListView(children: [
                    colorTitle(),
                    const SizedBox(height: 10),
                    const Divider(indent: 4, endIndent: 4),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rapport',
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: fontFamily)),
                              GetBuilder<AcceuilController>(
                                  builder: (controller) => myDropDown(
                                      items: controller.dropRap,
                                      value: controller.selectedRap,
                                      onChanged: (value) {
                                        controller.updateDropRap(value);
                                      }))
                            ])),
                    nbRdvWidget(),
                    Row(children: [
                      Expanded(flex: 7, child: patientRapport()),
                      const SizedBox(width: 10),
                      Expanded(flex: 6, child: sexeRapport())
                    ])
                  ])))),
      if (AppSizes.widthScreen > 1050) listRdvWidget()
    ]);
  }

  sexeRapport() => Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(primary: false, shrinkWrap: true, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Sexe',
              style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: fontFamily)),
          GetBuilder<AcceuilSexeChartController>(
              builder: (controller) => Visibility(
                  visible: !controller.loadingSexeList,
                  replacement: const ConnectWidget(),
                  child: myDropDown(
                      items: controller.dropRapSexe,
                      value: controller.selectedRapSexe,
                      onChanged: (value) {
                        controller.updateDropRapSexe(value);
                      })))
        ]),
        SizedBox(
            height: 200,
            child: Stack(children: [
              mySexeChart(),
              Center(
                  child: GetBuilder<AcceuilSexeChartController>(
                      builder: (controller) => Visibility(
                          visible: !controller.loadingSexeData,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(formatter.format(controller.nbTotalSexe),
                                    style: TextStyle(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        fontFamily: fontFamily)),
                                Text('Total',
                                    style: TextStyle(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: fontFamily))
                              ])))),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                          width: 20,
                          color: AppColor.blue1,
                          child: const Text('    ')),
                      const SizedBox(width: 10),
                      Text('Homme',
                          style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: fontFamily))
                    ]),
                    const SizedBox(height: 10),
                    Row(children: [
                      Container(
                          width: 20,
                          color: AppColor.pink,
                          child: const Text('    ')),
                      const SizedBox(width: 10),
                      Text('Femme',
                          style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: fontFamily))
                    ])
                  ])
            ]))
      ]));

  mySexeChart() => GetBuilder<AcceuilSexeChartController>(
      builder: (controller) => Visibility(
          visible: !controller.loadingSexeData,
          replacement: const Center(child: ConnectWidget()),
          child: PieChart(
              swapAnimationCurve: Curves.bounceInOut,
              swapAnimationDuration: const Duration(seconds: 2),
              PieChartData(centerSpaceRadius: 50, sections: [
                PieChartSectionData(
                    value: controller.nbHomme,
                    title:
                        '${(controller.nbHomme * 100 / controller.nbTotalSexe).toStringAsFixed(0)}%',
                    titleStyle: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: fontFamily),
                    color: AppColor.blue1),
                PieChartSectionData(
                    value: controller.nbFemme,
                    titleStyle: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: fontFamily),
                    title:
                        '${(controller.nbFemme * 100 / controller.nbTotalSexe).toStringAsFixed(0)}%',
                    color: AppColor.pink)
              ]))));

  patientRapport() => Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(primary: false, shrinkWrap: true, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Patients',
              style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: fontFamily)),
          GetBuilder<AcceuilRapportPatientController>(
              builder: (controller) => myDropDown(
                  items: controller.dropRapPat,
                  value: controller.selectedRapPat,
                  onChanged: (value) {
                    controller.updateDropRapPat(value);
                  }))
        ]),
        const SizedBox(height: 10),
        SizedBox(
            height: 300,
            child: GetBuilder<AcceuilRapportPatientController>(
                builder: (controller) => Visibility(
                    visible: !controller.loading,
                    replacement: const ConnectWidget(),
                    child: PatientRappportLineChart())))
      ]));

  nbRdvWidget() => GetBuilder<RDVController>(
      builder: (controller) => Wrap(children: [
            itemNbRdv(
                label: 'Total Patient(s)',
                controller: controller,
                icon: Icons.person_2_outlined,
                nb: controller.rdvs.length,
                colors: [
                  const Color.fromARGB(255, 200, 213, 220).withOpacity(0.6),
                  const Color.fromARGB(255, 129, 165, 208).withOpacity(0.6)
                ]),
            itemNbRdv(
                label: 'Patient Absent(s)',
                controller: controller,
                icon: Icons.call_missed_outgoing_outlined,
                nb: controller.getNbRdvs(etat: 0),
                colors: [
                  const Color.fromARGB(255, 217, 206, 206).withOpacity(0.6),
                  const Color.fromARGB(255, 211, 142, 142).withOpacity(0.6)
                ]),
            itemNbRdv(
                label: 'Patient en Attente(s)',
                controller: controller,
                icon: Icons.watch_later_outlined,
                nb: controller.getNbRdvs(etat: 1),
                colors: [
                  const Color.fromARGB(255, 239, 239, 215).withOpacity(0.6),
                  const Color.fromARGB(255, 208, 200, 129).withOpacity(0.6)
                ]),
            itemNbRdv(
                label: 'Patient Consulté(s)',
                controller: controller,
                icon: Icons.content_paste_rounded,
                nb: controller.getNbRdvs(etat: 2),
                colors: [
                  const Color.fromARGB(255, 221, 242, 222).withOpacity(0.6),
                  const Color.fromARGB(255, 144, 208, 129).withOpacity(0.6)
                ])
          ]));

  itemNbRdv(
          {required int nb,
          required RDVController controller,
          required String label,
          required IconData icon,
          required List<Color> colors}) =>
      Container(
          width: 190,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors)),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, size: 20),
              const SizedBox(width: 5),
              Expanded(
                  child: FittedBox(
                      child: Text(label,
                          style:
                              TextStyle(fontSize: 14, fontFamily: fontFamily))))
            ]),
            Visibility(
                visible: !controller.loading,
                replacement: const CircularProgressIndicator.adaptive(),
                child: Text(controller.error ? "x" : nb.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 48,
                        color: controller.error ? AppColor.red : AppColor.black,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.bold)))
          ]));

  myDropDown(
          {required String? value,
          required List<String> items,
          required Function(String?)? onChanged}) =>
      Container(
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: AppColor.grey)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  padding: const EdgeInsets.all(4),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColor.black,
                      fontFamily: fontFamily),
                  underline: null,
                  value: value,
                  items: items
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: onChanged)));

  colorTitle() => Container(
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
              mytextRdv(
                  text1: Text("Vous avez au total ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: fontFamily,
                          color: AppColor.white)),
                  text2: GetBuilder<RDVController>(
                      builder: (controller) => Text(
                          "${controller.rdvs.length} rendez-vous",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontFamily,
                              color: Colors.yellow))),
                  text3: Text(" aujourdh'ui",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: fontFamily,
                          color: AppColor.white))),
              const SizedBox(height: 10)
            ]),
        if (AppSizes.widthScreen > 750)
          Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: SizedBox(
                  width: AppSizes.heightScreen / 3,
                  child: Visibility(
                      visible: User.sexe == 1,
                      replacement: Lottie.asset(AppAnimationAsset.nurse),
                      child: Lottie.asset(AppAnimationAsset.doctor))))
      ]));

  mytextRdv(
          {required Widget text1,
          required Widget text2,
          required Widget text3}) =>
      Visibility(
          visible: (AppSizes.widthScreen > 600),
          replacement: petitModel(text1: text1, text2: text2, text3: text3),
          child: grandModel(text1: text1, text2: text2, text3: text3));

  grandModel(
          {required Widget text1,
          required Widget text2,
          required Widget text3}) =>
      Row(children: [text1, text2, text3]);

  petitModel(
          {required Widget text1,
          required Widget text2,
          required Widget text3}) =>
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [text1, text2, text3]);

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
