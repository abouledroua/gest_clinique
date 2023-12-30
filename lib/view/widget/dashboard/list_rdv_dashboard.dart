import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../controller/rdv_controller.dart';
import '../../../core/class/patient.dart';
import '../../../core/class/rdv.dart';
import '../../../core/constant/color.dart';
import '../login_register/connect_widget.dart';

class ListRdvDashBoard extends StatelessWidget {
  ListRdvDashBoard({super.key});

  final List<Color> absentGradColor = [
    const Color.fromARGB(255, 233, 128, 128).withOpacity(0.6),
    const Color.fromARGB(255, 223, 199, 199).withOpacity(0.4),
  ];
  final List<Color> attentGradColor = [
    const Color.fromARGB(255, 250, 245, 96).withOpacity(0.6),
    const Color.fromARGB(255, 237, 235, 193).withOpacity(0.4),
  ];
  final List<Color> consultGradColor = [
    const Color.fromARGB(255, 96, 242, 103).withOpacity(0.6),
    const Color.fromARGB(255, 177, 222, 179).withOpacity(0.4),
  ];

  @override
  Widget build(BuildContext context) => Card(
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(children: [
            header(),
            const Divider(color: AppColor.black),
            Expanded(child: listOfRdvs()),
            nbrRdvs(context)
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

  listOfRdvs() => GetBuilder<RDVController>(
      builder: (controller) => Visibility(
          visible: !controller.loading,
          replacement: const ConnectWidget(),
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.rdvs.length,
              itemBuilder: (context, i) {
                RDV item = controller.rdvs[i];
                Patient p = item.patient;
                DateTime date = DateTime.now();
                String today = '${date.year}${date.month}${date.day}';
                if (item.dateRdv != today) return null;

                return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: item.etat == 1
                                    ? absentGradColor
                                    : item.etat == 2
                                        ? attentGradColor
                                        : consultGradColor)),
                        child: ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            horizontalTitleGap: 0,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 3),
                            minVerticalPadding: 0,
                            minLeadingWidth: 0,
                            title: Text('${p.nom} ${p.prenom}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 12)),
                            subtitle: Visibility(
                                visible: item.dateDernConsult.isNotEmpty,
                                child: Text(
                                    'Dern. Cons. :${DateFormat("yyyy-MM-dd").format(DateTime.parse(item.dateDernConsult))}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 11))))));
              })));
}
