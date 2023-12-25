import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../core/constant/image_asset.dart';
import '../../core/constant/sizes.dart';
import '../widget/login/loginwidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      SizedBox(
          width: AppSizes.widthScreen,
          height: AppSizes.heightScreen,
          child: Image.asset(AppImageAsset.wall, fit: BoxFit.fill)),
      Center(
          child: Container(
              width: AppSizes.widthScreen / 3,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.symmetric(
                  vertical: AppSizes.heightScreen / 10,
                  horizontal: AppSizes.widthScreen / 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.4)),
              child: LoginWidget()))
    ])));
  }
}
