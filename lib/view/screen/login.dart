import 'package:flutter/material.dart';
import 'package:gest_clinique/core/constant/image_asset.dart';
import 'package:get/get.dart';

import '../../controller/login_controller.dart';
import '../../core/constant/sizes.dart';
import '../widget/login_register/loginwidget.dart';
import '../widget/mywidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return MyWidget(
        backgroudImage: AppImageAsset.wall,
        child: Center(
            child: Container(
                width: AppSizes.widthScreen / 3,
                margin: EdgeInsets.symmetric(
                    vertical: AppSizes.heightScreen / 10,
                    horizontal: AppSizes.widthScreen / 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.4)),
                child: const LoginWidget())));
  }
}
