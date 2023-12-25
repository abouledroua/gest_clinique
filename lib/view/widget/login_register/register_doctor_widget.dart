import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/register_doctor_controller.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';
import '../my_text_field.dart';

class RegisterDoctorWidget extends StatelessWidget {
  const RegisterDoctorWidget({super.key});

  final double chpHeight = 40;
  @override
  Widget build(BuildContext context) => Column(children: [
        SizedBox(
            width: AppSizes.widthScreen / 5,
            height: AppSizes.heightScreen / 5,
            child: Lottie.asset(AppAnimationAsset.registerDocteur)),
        Center(
            child: Text('Inscription',
                style: TextStyle(
                    fontSize: 24,
                    color: AppColor.primary,
                    fontFamily: fontFamily))),
        const SizedBox(height: 5),
        GetBuilder<RegisterDoctorController>(
            builder: (controller) => Visibility(
                visible: !controller.inscr,
                replacement: Expanded(child: succesWidget(controller)),
                child: Expanded(child: champs())))
      ]);

  succesWidget(RegisterDoctorController controller) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            height: 100,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Lottie.asset(AppAnimationAsset.success)),
                  Expanded(
                      child: Text(
                          'Nouveau ${controller.selectedFonction} Inscris',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamily,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold)))
                ]))
      ]);

  champs() => Column(children: [
        Expanded(child: listChamps()),
        const SizedBox(height: 10),
        const Divider(color: AppColor.black),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("J'ai déjà un compte , ",
              style: TextStyle(fontSize: 11, fontFamily: fontFamily)),
          InkWell(
              onTap: () {
                Get.toNamed(AppRoute.login);
              },
              child: Ink(
                  child: Text("Connecter",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: fontFamily,
                          color: AppColor.green2,
                          fontWeight: FontWeight.bold))))
        ])
      ]);

  ListView listChamps() => ListView(children: [
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterDoctorController>(
                builder: (controller) => MyTextField(
                    labelText: 'Votre Nom',
                    hintText: 'Nom et Prénom de la personne',
                    keyboardType: TextInputType.name,
                    upperCase: true,
                    controller: controller.nameController,
                    enabled: true))),
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterDoctorController>(
                builder: (controller) => MyTextField(
                    labelText: 'Votre Email',
                    hintText: 'email@gmail.com',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: true))),
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterDoctorController>(
                builder: (controller) => MyTextField(
                    labelText: 'Mot de Passe',
                    hintText: '1234',
                    obscureText: true,
                    controller: controller.passController,
                    keyboardType: TextInputType.visiblePassword,
                    enabled: true))),
        const SizedBox(height: 5),
        Container(
            height: chpHeight,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 240, 221),
                border: Border.all(),
                borderRadius: BorderRadius.circular(3)),
            child: Expanded(
                child: GetBuilder<RegisterDoctorController>(
                    builder: (controller) => DropdownButton(
                        padding: const EdgeInsets.all(8),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColor.black,
                            fontFamily: fontFamily),
                        underline: null,
                        value: controller.selectedOrg,
                        items: controller.orgs
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: (String? value) {
                          controller.updateDropOrg(value);
                        })))),
        const SizedBox(height: 5),
        Container(
            height: chpHeight,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 240, 221),
                border: Border.all(),
                borderRadius: BorderRadius.circular(3)),
            child: Expanded(
                child: GetBuilder<RegisterDoctorController>(
                    builder: (controller) => DropdownButton(
                        padding: const EdgeInsets.all(8),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColor.black,
                            fontFamily: fontFamily),
                        underline: null,
                        value: controller.selectedFonction,
                        items: controller.fonctions
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: (String? value) {
                          controller.updateDropFct(value);
                        })))),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text("Mon Cabinet n'apparaît pas dans la liste !!!, ",
              style: TextStyle(fontSize: 9, fontFamily: fontFamily)),
          Text("Ajouter",
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: fontFamily,
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(5)),
            child: TextButton(
                onPressed: () {
                  RegisterDoctorController controller = Get.find();
                  controller.inscrire();
                },
                child: Text('Inscrire',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.white,
                        fontFamily: fontFamily))))
      ]);
}
