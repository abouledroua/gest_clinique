import 'package:flutter/material.dart';

import 'core/constant/routes.dart';
import 'view/screen/dashboard.dart';
import 'view/screen/fiche_rdv.dart';
import 'view/screen/list_patient.dart';
import 'view/screen/login.dart';
import 'view/screen/register_cabinet.dart';
import 'view/screen/register_user.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.login: (context) => const LoginPage(),
  AppRoute.registerUser: (context) => const RegisterUserPage(),
  AppRoute.registerCabinet: (context) => const RegisterCabinetPage(),
  AppRoute.dashboard: (context) => const DashBoardPage(),
  AppRoute.ficheRdv: (context) => const FicheRdv(),
  AppRoute.listPatient: (context) => const ListPatientPage(),
};
