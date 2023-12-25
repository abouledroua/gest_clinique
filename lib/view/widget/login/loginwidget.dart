import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/login_controller.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';
import '../my_text_field.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) => ListView(children: [
        SizedBox(
            width: AppSizes.widthScreen / 5,
            height: AppSizes.heightScreen / 5,
            child: Lottie.asset(AppAnimationAsset.login2)),
        Center(
            child: Text(DateTime.now().hour > 12 ? 'Bonsoir' : 'Bonjour',
                style: TextStyle(
                    fontSize: 24,
                    color: AppColor.primary,
                    fontFamily: fontFamily))),
        const SizedBox(height: 5),
        const SizedBox(
            height: 30,
            child: MyTextField(
                labelText: 'Votre Email',
                hintText: 'email@gmail.com',
                keyboardType: TextInputType.emailAddress,
                enabled: true)),
        const SizedBox(height: 5),
        const SizedBox(
            height: 30,
            width: 30,
            child: MyTextField(
                labelText: 'Mot de Passe',
                hintText: '1234',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                enabled: true)),
        const SizedBox(height: 5),
        Container(
            height: 30,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 240, 221),
                border: Border.all(),
                borderRadius: BorderRadius.circular(3)),
            child: Expanded(
                child: GetBuilder<LoginController>(
                    builder: (controller) => DropdownButton(
                        padding: const EdgeInsets.all(8),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColor.black,
                            fontFamily: fontFamily),
                        underline: null,
                        value: controller.selectedItem,
                        items: controller.items
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: (String? value) {
                          controller.updateDrop(value);
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
                color: AppColor.green2, borderRadius: BorderRadius.circular(5)),
            child: TextButton(
                onPressed: () {},
                child: Text('Login',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.white,
                        fontFamily: fontFamily)))),
        const SizedBox(height: 10),
        const Center(child: Text(' _____________  Ou  ____________ ')),
        const SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(5)),
            child: TextButton.icon(
                icon: const Icon(Icons.g_mobiledata_rounded,
                    color: AppColor.green2),
                onPressed: () {},
                label: Text('Continuer avec Google',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColor.greyShade,
                        fontFamily: fontFamily)))),
        const SizedBox(height: 10),
        const Divider(color: AppColor.black),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Vous n'avez pas un compte , ",
              style: TextStyle(fontSize: 11, fontFamily: fontFamily)),
          Text("Inscriver",
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: fontFamily,
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold))
        ]),
      ]);
}
