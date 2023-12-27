import 'package:flutter/material.dart';

class MenuDashBoard extends StatelessWidget {
  const MenuDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Card(child: TextButton(onPressed: () {}, child: const Text('Malades')))
    ]));
  }
}
