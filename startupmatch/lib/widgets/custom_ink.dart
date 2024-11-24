import 'dart:io';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class CrossListElement extends StatelessWidget {
  const CrossListElement({
    Key? key,
    required this.onPressed,
    required this.child,
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final bool enabled;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Platform.isIOS
            ? CupertinoInkWell(
                onPressed: onPressed,
                child: OnTapScaleAndFade(
                  onTap: onPressed!,
                  lowerBound: 0.98,
                  child: Opacity(
                    opacity: enabled ? 1 : 0.6,
                    child: child,
                  ),
                ),
              )
            : InkWell(
                onTap: onPressed,
                child: OnTapScaleAndFade(
                  lowerBound: 0.98,
                  onTap: onPressed!,
                  child: Opacity(
                    opacity: enabled ? 1 : 0.6,
                    child: child,
                  ),
                ),
              ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
          ),
          height: 0.6,
        )
      ],
    );
  }
}

class CupertinoInkWell extends StatefulWidget {
  const CupertinoInkWell({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  bool get enabled => onPressed != null;

  @override
  State<CupertinoInkWell> createState() => _CupertinoInkWellState();
}

class _CupertinoInkWellState extends State<CupertinoInkWell> {
  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = true;
      });
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = false;
      });
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      setState(() {
        _buttonHeldDown = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.enabled;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        child: AnimatedContainer(
          color: _buttonHeldDown
              ? Theme.of(context).dividerColor.withAlpha(100)
              : Theme.of(context).scaffoldBackgroundColor,
          duration: Duration(milliseconds: 200),
          child: widget.child,
        ),
      ),
    );
  }
}
