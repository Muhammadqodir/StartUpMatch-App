import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/appbar.dart';

class ContentMain extends StatelessWidget {
  ContentMain({super.key});

  final List<String> videos = [
    "https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
    "https://www.exit109.com/~dnn/clips/RW20seconds_2.mp4",
  ];

  final List<String> images = [
    "assets/demo1.jpeg",
    "assets/demo2.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.vertical,
          children: images
              .map(
                (e) => Expanded(
                  child: Center(
                    child: Text(e),
                  ),
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
