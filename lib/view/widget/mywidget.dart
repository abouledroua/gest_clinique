import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';

class MyWidget extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final String? title;
  final List<Widget>? actions;
  final String? backgroudImage;
  final Color? color;
  final Widget? drawer, leading;

  const MyWidget({
    super.key,
    required this.child,
    this.backgroudImage,
    this.color,
    this.title,
    this.drawer,
    this.actions,
    this.leading,
    this.floatingActionButton,
  });

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
            appBar: title == null
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
                        child: Text(title ?? "",
                            style: Theme.of(context).textTheme.displayLarge))),
            floatingActionButton: floatingActionButton,
            drawer: drawer,
            resizeToAvoidBottomInset: true,
            body: child)
      ]));
}
