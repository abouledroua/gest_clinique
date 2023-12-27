import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/color.dart';

class ListRdvDashBoard extends StatelessWidget {
  const ListRdvDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(
            child: Text(
                "Liste des Rendez-vous\n${DateFormat('EEEE d MMMM y').format(DateTime.now())}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)))
      ]),
      const Divider(color: AppColor.black),
      Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => const ListTile())),
      const SizedBox(height: 20.0),
    ]);
  }
}
