import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/card.dart';

class PitchPreview extends StatefulWidget {
  const PitchPreview({super.key, this.margin = const EdgeInsets.only(top: 24)});

  final EdgeInsets margin;

  @override
  State<PitchPreview> createState() => _PitchPreviewState();
}

class _PitchPreviewState extends State<PitchPreview> {
  @override
  Widget build(BuildContext context) {
    return MyCard(
      title: "Braille Recognition",
      margin: widget.margin,
      child: Column(
        children: [
          Image.asset(
            "assets/demo1.jpeg",
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
