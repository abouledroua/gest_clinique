import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/fiche_rdv_controller.dart';
import '../../core/constant/animation_asset.dart';
import '../../core/constant/color.dart';
import '../../core/constant/sizes.dart';
import '../../core/constant/theme.dart';
import '../../main.dart';
import '../widget/my_text_field.dart';
import '../widget/mywidget.dart';

class FicheRdv extends StatelessWidget {
  const FicheRdv({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    final args = Get.arguments;
    Get.put(FicheRdvController(
        idrdv: int.parse(args == null ? '0' : args['idRdv']),
        codeBarre: args == null ? '' : args['CodeBarre']));
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
                      Expanded(
                          child: Visibility(
                              visible: !controller.loadingPat,
                              replacement: const Center(
                                  child: CircularProgressIndicator.adaptive()),
                              child: Visibility(
                                  visible: controller.p != null,
                                  replacement: TextButton(
                                      onPressed: () {
                                        controller.infoPatient('000006');
                                      },
                                      child: const Text('Get Patient')),
                                  child:
                                      const Text("Patient Sélectionné !!!")))),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: AppSizes.widthScreen / 10),
                          width: 20,
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: AppColor.grey)))),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Expanded(child: myCalendar(controller)),
                            const SizedBox(height: 10),
                            Divider(
                                color: AppColor.black,
                                endIndent: AppSizes.widthScreen / 10,
                                indent: AppSizes.widthScreen / 10),
                            Text(
                                'Date du nouveau Rendez-vous : ${DateFormat('y/MM/dd').format(controller.dateRdv)}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontFamily,
                                    fontSize: 32)),
                            const SizedBox(height: 10),
                            MyTextField(
                                labelText: 'Motif de Rendez-vous',
                                hintText: 'Motif de Rendez-vous',
                                controller: controller.motifController,
                                keyboardType: TextInputType.text,
                                enabled: true)
                          ]))
                    ]))));
  }

  myCalendar(FicheRdvController controller) => TableCalendar(
      onDaySelected: (selectedDay, focusedDay) {
        debugPrint('$selectedDay, $focusedDay');
        controller.updateDateRdv(selectedDay);
      },
      selectedDayPredicate: (day) =>
          isSameDay(day, controller.dateRdv) &&
          (day.weekday != DateTime.friday),
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
