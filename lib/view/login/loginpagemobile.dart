import 'package:flutter/material.dart';

import '../../core/constant/image_asset.dart';
import '../../core/constant/sizes.dart';

class LoginPageMobile extends StatelessWidget {
  const LoginPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    return Column(children: [
      const SizedBox(height: 100),
      SizedBox(
          width: AppSizes.widthScreen / 6,
          child: Image.asset(AppImageAsset.logo)),
      const Text('Logiiiiiiiiiiiin Mooooobile'),
    ]);
  }
}
