import 'package:flutter/material.dart';

import '../../../core/constant/image_asset.dart';
import '../../../core/constant/theme.dart';
import 'header_icons.dart';

class HeaderDashBoardWidget extends StatelessWidget {
  const HeaderDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6),
        child: Row(children: [
          Image.asset(AppImageAsset.logo),
          Text('Gestion Cabinet Médical',
              style: TextStyle(fontSize: 18, fontFamily: fontFamily)),
          const Spacer(),
          const SearchBar(
              textCapitalization: TextCapitalization.characters,
              hintText: 'Rechercher un Patient',
              leading: Icon(Icons.search_rounded)),
          const Spacer(),
          const HeaderIcons(),
        ]));
  }
}
