import 'package:flutter/material.dart';

import '../../core/class/user.dart';
import '../../core/constant/theme.dart';

class PageAcceuil extends StatelessWidget {
  const PageAcceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const SizedBox(height: 30),
      Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: User.sexe == 2
                      ? const [
                          Color.fromARGB(255, 163, 208, 245),
                          Color.fromARGB(255, 71, 162, 237)
                        ]
                      : const [
                          Color.fromARGB(255, 253, 157, 189),
                          Color.fromARGB(255, 253, 56, 122)
                        ])),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome back',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontFamily: fontFamily)),
                Text(User.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, fontFamily: fontFamily))
              ]))
    ]);
  }
}
