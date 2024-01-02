import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/login_controller.dart';
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

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  final double chpHeight = 35;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        SizedBox(
            width: AppSizes.widthScreen / 5,
            height: AppSizes.heightScreen / 5,
            child: Lottie.asset(AppAnimationAsset.heart)),
        Center(
            child: Text(DateTime.now().hour > 12 ? 'Bonsoir' : 'Bonjour',
                style: TextStyle(
                    fontSize: 24,
                    color: AppColor.primary,
                    fontFamily: fontFamily))),
        const SizedBox(height: 5),
        GetBuilder<LoginController>(
            builder: (controller) => Visibility(
                visible: !controller.valider,
                replacement: const ConnectWidget(),
                child: Visibility(
                    visible: !controller.conect,
                    replacement: Expanded(
                        child: SuccessWidget(
                            text:
                                'Authentification avec succès dans \n ${controller.selectedOrg}')),
                    child: Expanded(child: champs()))))
      ]));

  champs() => Column(children: [
        Expanded(child: listOfChamps()),
        const Divider(color: AppColor.black),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Text("Vous n'avez pas un compte , ",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 11, fontFamily: fontFamily))),
          InkWell(
              onTap: () {
                if (Get.isRegistered<RegisterUserController>()) {
                  Get.delete<RegisterUserController>();
                }
                Get.toNamed(AppRoute.registerUser);
              },
              child: Ink(
                  child: Text(" Inscriver",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: fontFamily,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold))))
        ]),
        const SizedBox(height: 5)
      ]);

  listOfChamps() => ListView(children: [
        SizedBox(
            height: chpHeight,
            child: Row(children: [
              Expanded(
                  child: GetBuilder<LoginController>(
                      builder: (controller) => AnimatedCrossFade(
                          duration: const Duration(seconds: 2),
                          firstChild: MyTextField(
                              labelText: 'Votre Email',
                              hintText: 'email@gmail.com',
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              enabled: true),
                          secondChild: MyTextField(
                              labelText: "Nom d'utilisateur",
                              hintText: 'Username',
                              controller: controller.usernameController,
                              keyboardType: TextInputType.text,
                              enabled: true),
                          crossFadeState: controller.connectEmail
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond))),
              const SizedBox(width: 10),
              InkWell(
                  onTap: () {
                    LoginController controller = Get.find();
                    controller.updateConnctEmail();
                  },
                  child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      height: chpHeight,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Icon(Icons.swap_horizontal_circle_rounded)))
            ])),
        const SizedBox(height: 5),
        SizedBox(
            height: chpHeight,
            child: GetBuilder<LoginController>(
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
            child: GetBuilder<LoginController>(
                builder: (controller) => Visibility(
                    visible: !controller.loading,
                    replacement: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator.adaptive(),
                          const SizedBox(width: 10),
                          Text('Chargement en cours ...',
                              style: TextStyle(
                                  fontSize: 11, fontFamily: fontFamily))
                        ]),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
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
                              controller.updateDrop(value ?? "");
                            }))))),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
              child: Text("Mon Cabinet n'apparaît pas dans la liste !!!, ",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 9, fontFamily: fontFamily))),
          InkWell(
              onTap: () {
                if (Get.isRegistered<RegisterCabinetController>()) {
                  Get.delete<RegisterCabinetController>();
                }
                Get.toNamed(AppRoute.registerCabinet);
              },
              child: Ink(
                  child: Text(" Ajouter",
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: fontFamily,
                          color: AppColor.secondary,
                          fontWeight: FontWeight.bold))))
        ]),
        const SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
                color: AppColor.green2, borderRadius: BorderRadius.circular(5)),
            child: TextButton(
                onPressed: () {
                  LoginController controller = Get.find();
                  controller.login();
                },
                child: Text('Connecter',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.white,
                        fontFamily: fontFamily)))),
        const SizedBox(height: 5)
      ]);
}
