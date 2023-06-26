import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';

import 'color.dart';
import 'sizes.dart';

class AppData {
  static openPlayStorePgae() {
    // const url = 'https://play.google.com/store/apps/details?id=com.bouledrouaamor.dziriapp';
    //  AppData.makeExternalRequest(uri: Uri.parse(url));
    LaunchReview.launch(androidAppId: 'com.bouledrouaamor.dziriapp');
  }

  static mySnackBar({required title, required message, required color}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: AppSizes.widthScreen,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: color,
        colorText: AppColor.white);
  }
}
