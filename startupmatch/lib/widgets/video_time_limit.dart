import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/upgrde_page/upgrade_page.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class VideoLimitWidget extends StatelessWidget {
  const VideoLimitWidget({super.key, required this.time});

  final int time;

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => const UpgradePage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              "max_length".tr(args: [time.toString()]),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            Text(
              "Upgrate to extend the limit",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
