import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/class/user.dart';
import '../../../core/constant/animation_asset.dart';
import '../../../core/constant/theme.dart';

class FooterDashBoardWidget extends StatelessWidget {
  const FooterDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6),
        child: Row(children: [
          Lottie.asset(AppAnimationAsset.hospital),
          Text(User.organisation,
              style: TextStyle(fontSize: 18, fontFamily: fontFamily)),
          const Spacer(),
          Lottie.asset(AppAnimationAsset.nurse),
          Text('${User.name} (${User.email})',
              style: TextStyle(fontSize: 18, fontFamily: fontFamily)),
          const Spacer(),
        ]));
  }
}
