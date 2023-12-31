import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/register_cabinet_controller.dart';
import '../../../controller/register_user_controller.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';
import '../my_text_field.dart';
import 'connect_widget.dart';
import 'success_widget.dart';

class RegisterUserWidget extends StatelessWidget {
  const RegisterUserWidget({super.key});

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
                  child: Lottie.asset(AppAnimationAsset.registerDocteur)),
              Center(
                  child: Text('Inscription',
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColor.primary,
                          fontFamily: fontFamily))),
              const SizedBox(height: 5),
              GetBuilder<RegisterUserController>(
                  builder: (controller) => Visibility(
                      visible: !controller.valider,
                      replacement: const ConnectWidget(),
                      child: Visibility(
                          visible: !controller.inscr,
                          replacement: Expanded(
                              child: SuccessWidget(
                                  text:
                                      'Nouveau ${controller.selectedFonction} Inscris')),
                          child: Expanded(child: champs()))))
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

  listChamps() => ListView(children: [
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterUserController>(
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
            child: GetBuilder<RegisterUserController>(
                builder: (controller) => MyTextField(
                    labelText: 'Votre Email',
                    hintText: 'email@gmail.com',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: true))),
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<RegisterUserController>(
                builder: (controller) => MyTextField(
                    labelText: 'Mot de Passe',
                    hintText: '1234',
                    obscureText: true,
                    controller: controller.passController,
                    keyboardType: TextInputType.visiblePassword,
                    enabled: true))),
        const SizedBox(height: 5),
        GetBuilder<RegisterUserController>(
            builder: (controller) => myDropDown(
                items: controller.sexes,
                value: controller.selectedSexe,
                onChanged: (String? value) {
                  controller.updateDropSexe(value ?? "");
                })),
        const SizedBox(height: 5),
        GetBuilder<RegisterUserController>(
            builder: (controller) => Visibility(
                visible: !controller.loading,
                replacement:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const CircularProgressIndicator.adaptive(),
                  const SizedBox(width: 10),
                  Text('Chargement en cours...',
                      style: TextStyle(fontSize: 11, fontFamily: fontFamily))
                ]),
                child: myDropDown(
                    items: controller.orgs,
                    value: controller.selectedOrg,
                    onChanged: (String? value) {
                      controller.updateDropOrg(value ?? "");
                    }))),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text("Mon Organisme n'apparaît pas dans la liste !!!, ",
              style: TextStyle(fontSize: 9, fontFamily: fontFamily)),
          InkWell(
              onTap: () {
                if (Get.isRegistered<RegisterCabinetController>()) {
                  Get.delete<RegisterCabinetController>();
                }
                Get.toNamed(AppRoute.registerCabinet);
              },
              child: Ink(
                  child: Text("Ajouter",
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: fontFamily,
                          color: AppColor.secondary,
                          fontWeight: FontWeight.bold))))
        ]),
        const SizedBox(height: 5),
        GetBuilder<RegisterUserController>(
            builder: (controller) => myDropDown(
                items: controller.fonctions,
                value: controller.selectedFonction,
                onChanged: (String? value) {
                  controller.updateDropFct(value ?? "");
                })),
        const SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(5)),
            child: TextButton(
                onPressed: () {
                  RegisterUserController controller = Get.find();
                  controller.saveClasse();
                },
                child: Text('Inscrire',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.white,
                        fontFamily: fontFamily))))
      ]);

  myDropDown(
          {required String? value,
          required List<String> items,
          required Function(String?)? onChanged}) =>
      Container(
          height: chpHeight,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 240, 221),
              border: Border.all(),
              borderRadius: BorderRadius.circular(3)),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  padding: const EdgeInsets.all(8),
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
}
