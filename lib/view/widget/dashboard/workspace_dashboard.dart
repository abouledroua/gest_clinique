import 'package:flutter/material.dart';

import 'footer_dashboard_widget.dart';

class WorkSpaceDashBoard extends StatelessWidget {
  const WorkSpaceDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Expanded(child: Text('ssss')),
      SizedBox(height: 45, child: FooterDashBoardWidget())
    ]);
  }
}
