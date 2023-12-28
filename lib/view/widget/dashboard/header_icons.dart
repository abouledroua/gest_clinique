import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/data.dart';
import '../../../core/constant/image_asset.dart';

class HeaderIcons extends StatelessWidget {
  const HeaderIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.asset(AppImageAsset.noPhoto),
      const SizedBox(width: 10),
      Tooltip(
          message: 'Déconnecter',
          child: InkWell(
              onTap: () {
                AppData.logout();
              },
              child: Ink(child: Lottie.asset(AppAnimationAsset.logout))))
    ]);
  }
}
