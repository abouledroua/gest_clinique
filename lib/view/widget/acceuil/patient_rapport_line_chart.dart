// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/acceuil_rapport_patient_controller.dart';
import '../../../core/constant/color.dart';
import '../../../main.dart';

class PatientRappportLineChart extends StatelessWidget {
  PatientRappportLineChart({super.key});

  final List<Color> gradientColors = [
    AppColor.amber,
    AppColor.blue1,
    AppColor.green
  ];
  List<String> libY = [];
  double pasY = 10;
  int month = 0;

  remplirLibY() {
    libY = [];
    AcceuilRapportPatientController controller = Get.find();
    int cp = -1;
    while (cp <= controller.vals.reduce(max)) {
      cp++;
      libY.add(formatter.format(cp));
    }
  }

  @override
  Widget build(BuildContext context) {
    remplirLibY();
    return AspectRatio(aspectRatio: 1.70, child: LineChart(mainData()));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    AcceuilRapportPatientController controller = Get.find();
    DateTime date = DateTime.parse(controller.libDuree[value.toInt()]);
    int type = controller.dropRapPat.indexOf(controller.selectedRapPat!);
    TextStyle style =
        TextStyle(fontWeight: FontWeight.bold, fontSize: type == 0 ? 16 : 12);
    Widget text = Text(
        DateFormat(type == 0
                ? 'EE\ndd MMM'
                : type == 1
                    ? month != date.month
                        ? 'EE\ndd MMM'
                        : 'dd\nMMM'
                    : 'MMMM')
            .format(date),
        textAlign: TextAlign.center,
        style: style);
    month = date.month;
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    String text = libY[value.round()];
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    month = 0;
    pasY = 10;
    AcceuilRapportPatientController controller = Get.find();
    if (controller.vals.reduce(max) > 100) {
      pasY = controller.vals.reduce(max) / 10;
    }
    double indexX = -1;
    return LineChartData(
        gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: pasY,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) =>
                const FlLine(color: AppColor.grey, strokeWidth: 1),
            getDrawingVerticalLine: (value) =>
                const FlLine(color: AppColor.grey, strokeWidth: 1)),
        titlesData: FlTitlesData(
            show: true,
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    interval: 1,
                    getTitlesWidget: bottomTitleWidgets)),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    interval: pasY,
                    getTitlesWidget: leftTitleWidgets,
                    reservedSize: 42))),
        borderData: FlBorderData(
            show: true, border: Border.all(color: const Color(0xff37434d))),
        minX: 0,
        maxX: controller.vals.length - 1.0,
        minY: 0,
        maxY: controller.vals.reduce(max) + 1,
        lineBarsData: [
          LineChartBarData(
              spots: controller.vals.map((e) {
                indexX++;
                return FlSpot(indexX, e);
              }).toList(),
              isCurved: true,
              gradient: LinearGradient(colors: gradientColors),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.3))
                          .toList())))
        ]);
  }
}
