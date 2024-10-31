import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:startupmatch/widgets/tap_scale.dart';

class SettingsItem extends StatefulWidget {
  SettingsItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.isSwitch = false});

  String title;
  IconData icon;
  bool isSwitch;
  Function onTap;

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
