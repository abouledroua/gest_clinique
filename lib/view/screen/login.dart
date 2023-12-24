import 'package:flutter/material.dart';

import '../../core/constant/image_asset.dart';
import '../../core/constant/sizes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      SizedBox(
          width: AppSizes.widthScreen,
          height: AppSizes.heightScreen,
          child: Image.asset(AppImageAsset.wallLogin, fit: BoxFit.fill)),
    ])));
  }
}
