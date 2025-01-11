import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.30),
            spreadRadius: 1,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
