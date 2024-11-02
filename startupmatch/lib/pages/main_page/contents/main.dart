import 'package:flutter/material.dart';
import 'package:startupmatch/data/test/test_data.dart';
import 'package:startupmatch/models/pitch.dart';
import 'package:startupmatch/widgets/appbar.dart';
import 'package:startupmatch/widgets/pitch.dart';

class ContentMain extends StatelessWidget {
  const ContentMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.vertical,
          children: [
            TestData.pitchModel,
            TestData.pitchModel,
          ]
              .map(
                (e) => Pitch(
                  model: TestData.pitchModel,
                ),
              )
              .toList(),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: MainAppBar(
            showAppBar: true,
            isTransparentAppBar: true,
            showShadow: false,
          ),
        ),
      ],
    );
  }
}
