import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSwitch = false,
  });

  final String title;
  final icon;
  final bool isSwitch;
  final Function onTap;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: () {
        widget.onTap();
      },
      lowerBound: 0.95,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 24,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black.withOpacity(0.6),
                    ),
              ),
            ),
            widget.isSwitch
                ? CupertinoSwitch(
                    value: true,
                    onChanged: (v) {
                      log(v.toString());
                    },
                    activeColor: Color(0xFF1DB2EC),
                  )
                : Icon(
                    CupertinoIcons.right_chevron,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.6),
                    size: 24,
                  ),
          ],
        ),
      ),
    );
  }
}
