import 'package:flutter/material.dart';

import '../../view/home_page/dashboard.dart';
import '../../view/login/loginpage.dart';

const loginRoute = '/login';
const dashBoard = '/DashBoard';

Map<String, Widget Function(BuildContext)> routes = {
  loginRoute: (context) => const LoginPage(),
  dashBoard: (context) => const DashBoard(),
};
