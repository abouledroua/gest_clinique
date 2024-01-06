import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/fiche_rdv_controller.dart';
import '../../controller/list_patient_controller.dart';
import '../../core/class/patient.dart';
import '../../core/constant/animation_asset.dart';
import '../../core/constant/color.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/sizes.dart';
import '../../core/constant/theme.dart';
import '../../main.dart';
import '../widget/my_button.dart';
import '../widget/my_text_field.dart';
import '../widget/mywidget.dart';

class FicheRdv extends StatelessWidget {
  const FicheRdv({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    final args = Get.arguments;
    Get.put(
        FicheRdvController(codeBarre: args == null ? '' : args['CodeBarre']));
    return MyWidget(
        gradient: myBackGradient,
        title: 'Fiche Rendez-vous',
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
            child: GetBuilder<FicheRdvController>(
                builder: (controller) => Row(children: [
                      Expanded(child: infosSection(controller)),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: AppSizes.widthScreen / 10),
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: AppColor.grey)))),
                      Expanded(child: myCalendar(controller))
                    ]))));
  }

  infosSection(FicheRdvController controller) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text('Information Patient',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
                color: AppColor.black)),
        SizedBox(width: double.infinity, child: patientSection(controller)),
        Divider(
            indent: AppSizes.widthScreen / 15,
            endIndent: AppSizes.widthScreen / 15),
        Text('Information Rendez-vous',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
                color: AppColor.black)),
        SizedBox(width: double.infinity, child: rdvSection(controller)),
        const SizedBox(height: 20),
        Divider(
            indent: AppSizes.widthScreen / 15,
            endIndent: AppSizes.widthScreen / 15),
        const SizedBox(height: 20),
        buttonSection(),
        const SizedBox(height: 30)
      ]));

  buttonSection() => GetBuilder<FicheRdvController>(
      builder: (controller) =>
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            MyButton(
                backGroundcolor: AppColor.white,
                frontColor: AppColor.red,
                icon: Icons.cancel,
                text: 'Annuler',
                onPressed: () {
                  if (controller.p == null) {
                    Get.back();
                  } else {
                    controller.p = null;
                    controller.update();
                  }
                }),
            MyButton(
                backGroundcolor: AppColor.green,
                frontColor: AppColor.white,
                icon: Icons.check_circle_outline,
                text: 'Valider',
                onPressed: () {
                  controller.saveClasse();
                })
          ]));

  patientSection(FicheRdvController controller) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (controller.loadingPat)
          const Center(child: CircularProgressIndicator.adaptive()),
        if (!controller.loadingPat && controller.p != null)
          patientInfosWidget(controller),
        if (!controller.loadingPat && controller.p == null)
          selectPatientWidget(controller)
      ]);

  rdvSection(FicheRdvController controller) => Column(children: [
        if (controller.loadingRdv)
          const Center(child: CircularProgressIndicator.adaptive()),
        if (!controller.loadingRdv && controller.r == null)
          Text('Aucun Rdv !!!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: fontFamily,
                  color: AppColor.amber)),
        if (!controller.loadingRdv && controller.r != null)
          myLabel(
              label: 'Date Ancien Rendez Vous : ',
              color: AppColor.blue1,
              data: controller.r!.dateRdv),
        const SizedBox(height: 10),
        myLabel(
            label: 'Date nouveau Rendez-vous : ',
            data: DateFormat('y/MM/dd').format(controller.dateRdv)),
        const SizedBox(height: 10),
        MyTextField(
            labelText: 'Motif de Rendez-vous',
            hintText: 'Motif de Rendez-vous',
            controller: controller.motifController,
            keyboardType: TextInputType.text,
            enabled: true)
      ]);

  selectPatientWidget(FicheRdvController controller) => SizedBox(
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
            width: 170,
            child: MyTextField(
                labelText: 'CodeBarre',
                hintText: '|||||||||||||||||',
                controller: controller.codebarreController,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (cb) {
                  controller.chargerInfo(cb);
                },
                enabled: true)),
        MyButton(
            backGroundcolor: AppColor.white,
            frontColor: AppColor.purple,
            icon: Icons.add_circle_outline_rounded,
            text: 'Rechercher un  Patient',
            onPressed: () async {
              if (Get.isRegistered<ListPatientController>()) {
                Get.delete<ListPatientController>();
              }
              await Get.toNamed(AppRoute.listPatient,
                  arguments: {"SELECT": '1'})?.then((value) {
                if (value != null) {
                  Patient p = value;
                  controller.chargerInfo(p.codeBarre);
                }
              });
            })
      ]));

  patientInfosWidget(FicheRdvController controller) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          myLabel(
              label: 'Nom : ',
              data: '${controller.p!.nom} ${controller.p!.prenom}'),
          myLabel(
              label: 'Age : ',
              data:
                  '${controller.p!.age} ${controller.p!.typeAge == 1 ? 'ans' : controller.p!.typeAge == 3 ? 'jours' : 'mois'}'),
          if (controller.p!.tel1.isNotEmpty || controller.p!.tel2.isNotEmpty)
            myLabel(
                label: 'Téléphone : ',
                data: (controller.p!.tel1.isNotEmpty &&
                        controller.p!.tel2.isNotEmpty)
                    ? '${controller.p!.tel1}  // ${controller.p!.tel2}'
                    : controller.p!.tel1.isNotEmpty
                        ? controller.p!.tel1
                        : controller.p!.tel2),
          myLabel(label: 'Sexe : ', data: controller.p!.getSexe()),
          if (controller.p!.getGS().isNotEmpty)
            myLabel(label: 'Groupe Sangain : ', data: controller.p!.getGS()),
          myLabel(
              label: 'Dette : ',
              dataBold: controller.p!.dette != 0,
              color: controller.p!.dette > 0 ? AppColor.red : AppColor.black,
              data: '${formatter.format(controller.p!.dette)} DA')
        ])),
        SizedBox(
            width: 165,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.purple)),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_document,
                              color: AppColor.purple),
                          label: Text('Modifier Infos',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: fontFamily,
                                  color: AppColor.purple)))),
                  const SizedBox(height: 15),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.green)),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.payment_rounded,
                              color: AppColor.green),
                          label: Text('Regler Dette',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: fontFamily,
                                  color: AppColor.green))))
                ]))
      ]));

  myLabel(
          {required String label,
          required String data,
          Color? color,
          bool dataBold = false}) =>
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: fontFamily,
                color: AppColor.black)),
        Text(data,
            style: TextStyle(
                fontWeight: dataBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 20,
                fontFamily: fontFamily,
                color: color ?? AppColor.black))
      ]);

  myCalendar(FicheRdvController controller) => TableCalendar(
      onDaySelected: (selectedDay, focusedDay) {
        debugPrint('$selectedDay, $focusedDay');
        controller.updateDateRdv(selectedDay);
      },
      selectedDayPredicate: (day) => isSameDay(day, controller.dateRdv),
      //  && (day.weekday != DateTime.friday),
      onHeaderTapped: (focusedDay) {
        // 1. show date picker
        // 2. update the focusedDay state with the selected date (from date picker)
      },
      sixWeekMonthsEnforced: true,
      daysOfWeekHeight: 30,
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
              fontSize: 20),
          weekdayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
              fontSize: 20)),
      calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
              color: AppColor.white, border: Border.all(color: AppColor.black)),
          todayTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
              fontSize: 30),
          defaultDecoration:
              BoxDecoration(border: Border.all(color: AppColor.black)),
          defaultTextStyle: TextStyle(fontFamily: fontFamily, fontSize: 24),
          disabledTextStyle:
              const TextStyle(color: AppColor.white, fontSize: 0),
          weekendDecoration:
              BoxDecoration(border: Border.all(color: AppColor.black)),
          weekendTextStyle: TextStyle(fontFamily: fontFamily, fontSize: 24),
          selectedDecoration: BoxDecoration(
              color: AppColor.amber.withOpacity(0.5),
              border: Border.all(color: AppColor.black)),
          selectedTextStyle: TextStyle(
              color: AppColor.red,
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
              fontSize: 24),
          holidayTextStyle: TextStyle(
              color: AppColor.red,
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
              fontSize: 24),
          outsideDaysVisible: false),
      locale: "fr-FR",
      availableGestures: AvailableGestures.all,
      formatAnimationCurve: Curves.ease,
      formatAnimationDuration: const Duration(seconds: 1),
      startingDayOfWeek: StartingDayOfWeek.saturday,
      headerStyle:
          const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      focusedDay: controller.dateRdv,
      firstDay: DateTime.now(),
      lastDay: DateTime(DateTime.now().year + 30, 12, 31));
}
