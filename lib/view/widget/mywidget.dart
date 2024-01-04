import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';
import '../../core/constant/theme.dart';

class MyWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Gradient? gradient;
  final List<Widget>? actions;
  final String? backgroudImage;
  final Widget? drawer, leading, floatingActionButton;

  const MyWidget(
      {super.key,
      required this.child,
      this.backgroudImage,
      this.gradient,
      this.title = "",
      this.drawer,
      this.actions,
      this.leading,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Stack(children: [
        if (backgroudImage != null)
          Positioned.fill(
              child:
                  Image(image: AssetImage(backgroudImage!), fit: BoxFit.fill)),
        Container(
            decoration: BoxDecoration(gradient: gradient),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: title == ""
                    ? null
                    : AppBar(
                        iconTheme: const IconThemeData(color: AppColor.black),
                        elevation: 0,
                        actions: actions,
                        centerTitle: true,
                        backgroundColor: Colors.transparent,
                        leading: leading ??
                            (Navigator.canPop(context)
                                ? IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.arrow_back))
                                : null),
                        title: FittedBox(
                            child: Text(title,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontFamily,
                                    color: AppColor.black)))),
                floatingActionButton: floatingActionButton,
                drawer: drawer,
                resizeToAvoidBottomInset: true,
                body: child))
      ]));
}
