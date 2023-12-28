import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';

class ConnectWidget extends StatelessWidget {
  const ConnectWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: min(100, AppSizes.widthScreen / 3),
                height: min(100, AppSizes.heightScreen / 3),
                child: Lottie.asset(AppAnimationAsset.connect)),
            Text('Traitement en cours ...',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontFamily,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold))
          ]);
}
