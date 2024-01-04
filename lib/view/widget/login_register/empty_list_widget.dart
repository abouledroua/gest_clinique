import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;
  const EmptyListWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: min(200, AppSizes.widthScreen / 3),
                height: min(200, AppSizes.heightScreen / 3),
                child: Lottie.asset(AppAnimationAsset.empty)),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: fontFamily,
                    color: AppColor.blue2,
                    fontWeight: FontWeight.bold))
          ]);
}
