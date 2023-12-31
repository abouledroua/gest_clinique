import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/register_cabinet_controller.dart';
import '../../core/constant/image_asset.dart';
import '../../core/constant/sizes.dart';
import '../widget/login_register/register_cabinet_widget.dart';
import '../widget/mywidget.dart';

class RegisterCabinetPage extends StatelessWidget {
  final int idCabinet;
  const RegisterCabinetPage({super.key, this.idCabinet = 0});

  @override
  Widget build(BuildContext context) {
    AppSizes.setSizeScreen(context);
    Get.put(RegisterCabinetController(idCabinet: idCabinet));
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
                child: const RegisterCabinetWidget())));
  }
}
