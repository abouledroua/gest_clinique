import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../controller/fiche_rdv_controller.dart';
import '../../../controller/rdv_controller.dart';
import '../../../core/class/rdv.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/theme.dart';
import '../../../main.dart';
import '../login_register/connect_widget.dart';
import '../login_register/erreur_widget.dart';
import '../my_button.dart';

class ListRdvDashBoard extends StatelessWidget {
  const ListRdvDashBoard({super.key});

  @override
  Widget build(BuildContext context) => Card(
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(children: [
            header(),
            const Divider(color: AppColor.black),
            Expanded(
                child: GetBuilder<RDVController>(
                    builder: (controller) => Visibility(
                        visible: !controller.loading,
                        replacement: const Center(child: ConnectWidget()),
                        child: Visibility(
                            visible: !controller.error,
                            replacement:
                                Center(child: ErreurWidget(onPressed: () {
                              controller.getRdvs();
                            })),
                            child: listOfRdvs(controller))))),
            GetBuilder<RDVController>(
                builder: (controller) => Visibility(
                    visible: !controller.loading && !controller.error,
                    child: nbrRdvs(context))),
          ])));

  header() => Container(
      color: AppColor.white,
      child: Stack(children: [
        Row(children: [
          Expanded(
              child: Text(
                  "Liste des Rendez-vous\n${DateFormat('EEEE d MMMM y').format(DateTime.now())}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)))
        ]),
        Positioned(
            left: -6,
            child: InkWell(
                onTap: () {
                  DashBoardController controller = Get.find();
                  controller.updateShowListeRDv();
                },
                child: Ink(child: const Icon(Icons.arrow_forward_rounded))))
      ]));

  nbrRdvs(BuildContext context) => Container(
      color: AppColor.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: GetBuilder<RDVController>(
                  builder: (controller) => Text(
                      'Nombre Total de Rdvs : ${controller.rdvs.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))))
        ]),
        const SizedBox(height: 3),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: absentGradColor)),
            width: double.infinity,
            child: GetBuilder<RDVController>(
                builder: (controller) => Text(
                    'Patients Absents: ${controller.getNbRdvs(etat: 0)}',
                    textAlign: TextAlign.start,
                    style:
                        const TextStyle(color: Colors.black, fontSize: 13)))),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: attentGradColor)),
            width: double.infinity,
            child: GetBuilder<RDVController>(
                builder: (controller) => Text(
                    'Patients en Attentes : ${controller.getNbRdvs(etat: 1)}',
                    textAlign: TextAlign.start,
                    style:
                        const TextStyle(color: Colors.black, fontSize: 13)))),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: consultGradColor)),
            width: double.infinity,
            child: GetBuilder<RDVController>(
                builder: (controller) => Text(
                    'Nombre de Consultations : ${controller.getNbRdvs(etat: 2)}',
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black, fontSize: 13))))
      ]));

  listOfRdvs(RDVController controller) => Column(children: [
        Center(
            child: MyButton(
                backGroundcolor: AppColor.white,
                frontColor: AppColor.green,
                smallSize: true,
                icon: Icons.add_circle_outline_rounded,
                text: 'Ajouter Rendez-vous',
                onPressed: () {
                  if (Get.isRegistered<FicheRdvController>()) {
                    Get.delete<FicheRdvController>();
                  }
                  Get.toNamed(AppRoute.ficheRdv,
                      arguments: {"CodeBarre": '', "idRdv": '0'});
                })),
        const SizedBox(height: 6),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () => controller.getRdvs(),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(Get.context!).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse
                        }),
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.rdvs.length,
                        itemBuilder: (context, i) {
                          RDV item = controller.rdvs[i];
                          return Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              padding: const EdgeInsets.only(right: 6),
                              child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: item.consult
                                              ? consultGradColor
                                              : item.etatRDV == 1
                                                  ? attentGradColor
                                                  : absentGradColor)),
                                  child: Row(children: [
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text('${item.nom} ${item.prenom}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 13)),
                                          Text(
                                              'Age : ${item.age} ${item.typeAge == 1 ? 'ans' : item.typeAge == 3 ? 'jours' : 'mois'}',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11)),
                                          if (item.heureArrivee.isNotEmpty &&
                                              !item.consult)
                                            Text(
                                                'Heure Arrivée : ${item.heureArrivee.substring(0, 5)}',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11)),
                                          if (item.motif.isNotEmpty)
                                            Text('Motif : ${item.motif}',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11)),
                                          if (item.consult)
                                            Text(
                                                'Versement : ${formatter.format(item.versement)} DA',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11)),
                                          if (item.dette != 0)
                                            Text(
                                                'Dette : ${formatter.format(item.dette)} DA',
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12))
                                        ])),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (!item.consult)
                                            const SizedBox(height: 2),
                                          if (!item.consult)
                                            Tooltip(
                                                message:
                                                    'Supprimer Rendez-vous',
                                                child: InkWell(
                                                    onTap: () {
                                                      controller
                                                          .removeRdv(item.id);
                                                    },
                                                    child: Ink(
                                                        child: Icon(
                                                            Icons
                                                                .delete_outline_rounded,
                                                            color: AppColor
                                                                .red)))),
                                          if (!item.consult)
                                            const SizedBox(height: 2),
                                          if (!item.consult)
                                            Tooltip(
                                                message:
                                                    'Modifier le Rendez-vous',
                                                child: InkWell(
                                                    onTap: () {
                                                      if (Get.isRegistered<
                                                          FicheRdvController>()) {
                                                        Get.delete<
                                                            FicheRdvController>();
                                                      }
                                                      Get.toNamed(
                                                          AppRoute.ficheRdv,
                                                          arguments: {
                                                            "CodeBarre":
                                                                item.codeBarre,
                                                            "idRdv": item.id
                                                                .toString()
                                                          });
                                                    },
                                                    child: Ink(
                                                        child: const Icon(Icons
                                                            .edit_calendar_outlined)))),
                                          const SizedBox(height: 2),
                                          if (!item.consult)
                                            Tooltip(
                                                message:
                                                    'Imprimer le Rendez-vous',
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Ink(
                                                        child: const Icon(Icons
                                                            .print_outlined)))),
                                          if (item.consult)
                                            Tooltip(
                                                message:
                                                    'Prendre un Rendez-vous',
                                                child: InkWell(
                                                    onTap: () {
                                                      if (Get.isRegistered<
                                                          FicheRdvController>()) {
                                                        Get.delete<
                                                            FicheRdvController>();
                                                      }
                                                      Get.toNamed(
                                                          AppRoute.ficheRdv,
                                                          arguments: {
                                                            "CodeBarre":
                                                                item.codeBarre,
                                                            "idRdv": '0'
                                                          });
                                                    },
                                                    child: Ink(
                                                        child: const Icon(Icons
                                                            .calendar_today_outlined)))),
                                          const SizedBox(height: 2),
                                        ])
                                  ])));
                        }))))
      ]);
}
