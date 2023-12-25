import 'package:flutter/material.dart';
import 'package:gest_clinique/core/constant/image_asset.dart';

import '../widget/mywidget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyWidget(
        backgroudImage: AppImageAsset.wall, child: Text('sss'));
  }
}
