import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/theme.dart';

class ErreurWidget extends StatelessWidget {
  final void Function()? onPressed;
  const ErreurWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: min(100, AppSizes.widthScreen / 3),
                height: min(100, AppSizes.heightScreen / 3),
                child: Lottie.asset(AppAnimationAsset.erreur)),
            const SizedBox(height: 10),
            Center(
                child: Text("une erreur s'est produite",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: fontFamily,
                        color: AppColor.red,
                        fontWeight: FontWeight.bold))),
            const SizedBox(height: 10),
            ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.restart_alt_rounded),
                label: const Text("Actualiser"))
          ]);
}
