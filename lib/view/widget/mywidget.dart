import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';

class MyWidget extends StatelessWidget {
  final Widget child;
  final bool blurBackground;
  final String title;
  final Gradient? gradient;
  final List<Widget>? actions;
  final String? backgroudImage;
  final Color? color;
  final Widget? drawer, leading, floatingActionButton;

  const MyWidget(
      {super.key,
      required this.child,
      this.backgroudImage,
      this.blurBackground = false,
      this.color,
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
        Scaffold(
            backgroundColor: color ??
                (backgroudImage != null ? Colors.transparent : AppColor.white),
            appBar: title == ""
                ? null
                : AppBar(
                    iconTheme: const IconThemeData(color: AppColor.black),
                    elevation: 0,
                    actions: actions,
                    centerTitle: true,
                    backgroundColor:
                        color != null ? AppColor.white : Colors.transparent,
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
                            style: Theme.of(context).textTheme.displayLarge))),
            floatingActionButton: floatingActionButton,
            drawer: drawer,
            resizeToAvoidBottomInset: true,
            body: blurBackground
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: child)
                : gradient != null
                    ? Container(
                        decoration: BoxDecoration(gradient: gradient),
                        child: child)
                    : child)
      ]));
}
