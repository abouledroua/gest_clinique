import 'package:flutter/material.dart';

import 'core/constant/routes.dart';
import 'view/screen/login.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.login: (context) => const LoginPage(),
  // AppRoute.privacy: (context) => const PrivacyPolicy(),
  // AppRoute.home: (context) => const HomePage(),
  // AppRoute.outDate: (context) => const OutDateVersion(),
  // AppRoute.expire: (context) => const VersionExpirerPage(),
  // AppRoute.listEnfants: (context) => const ListEnfants(),
  // AppRoute.listParents: (context) => const ListParents(),
  // AppRoute.listAnnonces: (context) => const ListAnnonces(),
  // AppRoute.listSections: (context) => const ListSections(),
  // AppRoute.listMessages: (context) => const ListMessages(),
  // AppRoute.listAlbum: (context) => const ListAlbums(),
  // AppRoute.listEnseignants: (context) => const ListEnseignants(),
};
