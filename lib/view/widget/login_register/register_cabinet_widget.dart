import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/register_cabinet_controller.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';
import '../my_text_field.dart';
import 'success_widget.dart';

class RegisterCabinetWidget extends StatelessWidget {
  const RegisterCabinetWidget({super.key});

  final double chpHeight = 40;
  @override
  Widget build(BuildContext context) => Stack(children: [
        InkWell(
            onTap: () {
              Get.back();
            },
            child: Ink(
                width: 35,
                height: 35,
                child: Lottie.asset(AppAnimationAsset.backArrow))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              SizedBox(
                  width: AppSizes.widthScreen / 5,
                  height: AppSizes.heightScreen / 5,
                  child: Lottie.asset(AppAnimationAsset.hospital)),
              Center(
                  child: Expanded(
                      child: Text(
                          'Cabinet Médical / Clinique \n Centre de Santé / Hopital',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.primary,
                              fontFamily: fontFamily)))),
              const SizedBox(height: 5),
              GetBuilder<RegisterCabinetController>(
                  builder: (controller) => Visibility(
                      visible: !controller.inscr,
                      replacement: const Expanded(
                          child: SuccessWidget(
                              text:
                                  'Nouveau Organisme de santé \najouter avec succés')),
                      child: Expanded(child: listChamps())))
            ]))
      ]);

  ListView listChamps() => ListView(children: [
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterCabinetController>(
                builder: (controller) => MyTextField(
                    labelText: "Nom de l'organisme",
                    hintText: "Cabinet .....",
                    keyboardType: TextInputType.name,
                    controller: controller.nameController,
                    enabled: true))),
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterCabinetController>(
                builder: (controller) => MyTextField(
                    labelText: 'Adresse Exacte',
                    hintText: 'cité ... Wilaya ... Algérie',
                    controller: controller.adrController,
                    keyboardType: TextInputType.streetAddress,
                    enabled: true))),
        const SizedBox(height: 5),
        Container(
            height: chpHeight,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 240, 221),
                border: Border.all(),
                borderRadius: BorderRadius.circular(3)),
            child: Expanded(
                child: GetBuilder<RegisterCabinetController>(
                    builder: (controller) => DropdownButtonHideUnderline(
                          child: DropdownButton(
                              padding: const EdgeInsets.all(8),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: AppColor.black,
                                  fontFamily: fontFamily),
                              underline: null,
                              value: controller.selectedWilaya,
                              items: controller.wilayas
                                  .map((item) => DropdownMenuItem(
                                      value: item, child: Text(item)))
                                  .toList(),
                              onChanged: (String? value) {
                                controller.updateDropWilaya(value);
                              }),
                        )))),
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterCabinetController>(
                builder: (controller) => MyTextField(
                    labelText: 'N° Téléphone',
                    hintText: '0777 777 777',
                    controller: controller.telController,
                    keyboardType: TextInputType.phone,
                    enabled: true))),
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterCabinetController>(
                builder: (controller) => MyTextField(
                    labelText: 'Adresse Email',
                    hintText: 'email@gmail.com',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: true))),
        const SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(5)),
            child: TextButton(
                onPressed: () {
                  RegisterCabinetController controller = Get.find();
                  controller.inscrire();
                },
                child: Text('Ajouter',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.white,
                        fontFamily: fontFamily)))),
        const SizedBox(height: 10)
      ]);
}
