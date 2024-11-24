import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionIcon extends StatefulWidget {
  const ActionIcon({
    super.key,
    required this.bgColor,
    required this.icon,
  });

  final IconData icon;
  final Color bgColor;

  @override
  State<ActionIcon> createState() => _ActionIconState();
}

class _ActionIconState extends State<ActionIcon> with TickerProviderStateMixin {
  late AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _tween.animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticOut)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: widget.bgColor,
        ),
        child: Icon(
          widget.icon,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
