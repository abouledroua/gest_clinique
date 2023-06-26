import 'package:flutter/material.dart';

import '../../core/constant/image_asset.dart';
import '../../main.dart';
import 'loginpagemobile.dart';
import 'loginpageweb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImageAsset.wallLogin),
                      fit: BoxFit.cover)),
              child: isMobilePlatform
                  ? const LoginPageMobile()
                  : const LoginPageWeb())));
}
