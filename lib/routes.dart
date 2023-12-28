import 'package:flutter/material.dart';

import 'core/constant/routes.dart';
import 'view/screen/dashboard.dart';
import 'view/screen/login.dart';
import 'view/screen/register_cabinet.dart';
import 'view/screen/register_doctor.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.login: (context) => const LoginPage(),
  AppRoute.registerUser: (context) => const RegisterUserPage(),
  AppRoute.registerCabinet: (context) => const RegisterCabinetPage(),
  AppRoute.dashboard: (context) => const DashBoardPage(),
};
