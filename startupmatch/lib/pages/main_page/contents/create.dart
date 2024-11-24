import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/buttons/gradient_button.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/listview.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';

class ContentCreate extends StatefulWidget {
  const ContentCreate({super.key});

  @override
  State<ContentCreate> createState() => _ContentCreateState();
}

class _ContentCreateState extends State<ContentCreate> {
  bool showShadow = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: MyListView(
            onTop: (v) {
              setState(() {
                showShadow = !v;
              });
            },
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 60,
                  bottom: 60,
                ),
                child: Column(
                  children: [
                    GradientButton(
                      margin: const EdgeInsets.all(24),
                      text: "test",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: MyAppBar(
            title: "create".tr(),
            showShadow: showShadow,
            action: [
              MyIconButton(
                onTap: () {},
                width: 28,
                height: 28,
                child: const Icon(
                  CupertinoIcons.bell,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
