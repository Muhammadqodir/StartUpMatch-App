import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    required this.onTap,
    required this.child,
    this.height = 40,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  });
  final double height;
  final double width;
  final Function onTap;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        alignment: Alignment.center,
        width: width,
        child: child,
      ),
    );
  }
}
