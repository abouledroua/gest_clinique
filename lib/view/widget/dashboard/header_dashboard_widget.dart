import 'package:flutter/material.dart';

import 'header_icons.dart';

class HeaderDashBoardWidget extends StatelessWidget {
  const HeaderDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
      height: 45,
      padding: const EdgeInsets.all(6),
      child: const Row(children: [
        Spacer(),
        Expanded(
            flex: 4,
            child: SearchBar(
                textCapitalization: TextCapitalization.characters,
                hintText: 'Rechercher un Patient',
                leading: Icon(Icons.search_rounded))),
        Spacer(),
        HeaderIcons()
      ]));
}
