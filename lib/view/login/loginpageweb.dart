import 'package:flutter/material.dart';

import 'webwiddget/authsectionloginwidget.dart';
import 'webwiddget/hisectionloginwidget.dart';

class LoginPageWeb extends StatelessWidget {
  const LoginPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(children: [HiSectionWidget(), AuthSectionWidget()]);
  }
}
