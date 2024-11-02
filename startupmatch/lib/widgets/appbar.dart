import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/icon_button.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    this.isTransparentAppBar = false,
    this.showAppBar = true,
    this.showShadow = false,
  });

  final bool isTransparentAppBar;
  final bool showAppBar;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return !showAppBar
        ? const SizedBox()
        : AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
              ],
              color: !isTransparentAppBar
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).scaffoldBackgroundColor.withAlpha(0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/ic_launcher.png",
                            width: 38,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "StartUp Match",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  MyIconButton(
                    onTap: () {},
                    width: 28,
                    height: 28,
                    child: const Icon(
                      CupertinoIcons.bell,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
