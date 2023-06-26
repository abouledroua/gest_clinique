import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HiSectionWidget extends StatelessWidget {
  const HiSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedTextKit(animatedTexts: [TyperAnimatedText('Hi')]),
      ],
    );
  }
}
