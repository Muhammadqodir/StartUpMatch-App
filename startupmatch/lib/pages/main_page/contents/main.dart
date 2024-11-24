import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/app_bar/appbar.dart';
import 'package:startupmatch/widgets/match_widget/match_widget.dart';

class ContentMain extends StatelessWidget {
  const ContentMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: 68,
          left: 12,
          right: 12,
          bottom: 80,
          child: SafeArea(
            child: MatchWidget(),
          ),
        ),
        Positioned(
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
