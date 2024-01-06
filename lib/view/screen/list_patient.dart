import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/list_patient_controller.dart';
import '../../controller/patient_controller.dart';
import '../../core/class/patient.dart';
import '../../core/constant/animation_asset.dart';
import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';
import '../../core/constant/theme.dart';
import '../../main.dart';
import '../widget/login_register/connect_widget.dart';
import '../widget/login_register/empty_list_widget.dart';
import '../widget/login_register/erreur_widget.dart';
import '../widget/my_button.dart';
import '../widget/my_text_field.dart';
import '../widget/mywidget.dart';

late bool select;

class ListPatientPage extends StatelessWidget {
  const ListPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    select = (args == null) ? false : (args['SELECT'] == "1");
    AppSizes.setSizeScreen(context);
    Get.put(ListPatientController());
    return MyWidget(
        gradient: myBackGradient,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: MyButton(
                  backGroundcolor: AppColor.white,
                  frontColor: AppColor.green,
                  icon: Icons.add_circle_outline_rounded,
                  text: 'Ajouter Patient',
                  onPressed: () {}))
        ],
        title: 'Liste des Patients',
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Ink(child: Lottie.asset(AppAnimationAsset.backArrow))),
        child: Container(
            padding: const EdgeInsets.all(6),
            margin: EdgeInsets.symmetric(
                horizontal: AppSizes.widthScreen / 70,
                vertical: AppSizes.heightScreen / 50),
            decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: GetBuilder<PatientController>(
                builder: (controller) => Visibility(
                    visible: !controller.loading,
                    replacement: const Center(child: ConnectWidget()),
                    child: Visibility(
                        visible: !controller.error,
                        replacement: Center(child: ErreurWidget(onPressed: () {
                          controller.getPatients();
                        })),
                        child: listOfPatients(controller))))));
  }

  listOfPatients(PatientController controller) => Column(children: [
        header(controller),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () => controller.getPatients(),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(Get.context!).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse
                        }),
                    child: Visibility(
                      visible: controller.showList.isNotEmpty,
                      replacement:
                          const EmptyListWidget(text: 'Aucun Patient !!!'),
                      child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.showList.length,
                          itemBuilder: (context, i) =>
                              myTile(controller.showList[i])),
                    ))))
      ]);

  header(PatientController controller) => Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            height: 30,
            width: AppSizes.widthScreen / 5,
            child: Expanded(
                child: GetBuilder<ListPatientController>(
              builder: (listController) => MyTextField(
                  labelText: 'Recherche',
                  hintText: 'Nom ou Prénom',
                  controller: listController.queryController,
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (p0) {
                    ListPatientController listController = Get.find();
                    controller.queryName = listController.queryController.text;
                    controller.filterList();
                  },
                  enabled: true),
            ))),
        const SizedBox(width: 10),
        SizedBox(
            height: 30,
            child: MyButton(
                backGroundcolor: AppColor.white,
                frontColor: AppColor.black,
                icon: Icons.search_rounded,
                text: 'Rechercher',
                onPressed: () {
                  ListPatientController listController = Get.find();
                  controller.queryName = listController.queryController.text;
                  controller.filterList();
                }))
      ]));

  myTile(Patient item) => InkWell(
        onTap: !select
            ? null
            : () {
                Get.back(result: item);
              },
        child: Ink(
          child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors:
                              item.isFemme ? femmeGradColor : hommeGradColor)),
                  child: Row(children: [
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('${item.fullname}  (${item.codeBarre})',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16)),
                          Text(
                              'Age : ${item.age} ${item.typeAge == 1 ? 'ans' : item.typeAge == 3 ? 'jours' : 'mois'}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text('Sexe : ${item.getSexe()}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          if (item.tel1.isNotEmpty || item.tel2.isNotEmpty)
                            Text(
                                'Téléphone : ${item.tel1.isNotEmpty && item.tel2.isNotEmpty ? '${item.tel1} // ${item.tel2}' : item.tel1.isNotEmpty ? item.tel1 : item.tel2}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 13)),
                          Text('Code Malade : ${item.codeMalade}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          if (item.dette != 0)
                            Text('Dette : ${formatter.format(item.dette)} DA',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 14))
                        ])),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Tooltip(
                              message: 'Supprimer Patient',
                              child: InkWell(
                                  onTap: () {
                                    // controller.removeRdv(item.id);
                                  },
                                  child: Ink(
                                      child: Icon(Icons.delete_outline_rounded,
                                          color: AppColor.red)))),
                          const SizedBox(height: 6),
                          Tooltip(
                              message: 'Modifier les Informations',
                              child: InkWell(
                                  onTap: () {
                                    // if (Get.isRegistered<    FicheRdvController>()) {
                                    //   Get.delete<     FicheRdvController>();
                                    // }
                                    // Get.toNamed(         AppRoute.ficheRdv,
                                    //     arguments: {       "CodeBarre":     item.codeBarre,
                                    //       "idRdv":   item.id.toString()            });
                                  },
                                  child: Ink(
                                      child: const Icon(
                                          Icons.edit_calendar_outlined)))),
                          const SizedBox(height: 2),
                        ])
                  ]))),
        ),
      );
}
