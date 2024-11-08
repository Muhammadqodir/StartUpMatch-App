import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/auth_page/auth_page.dart';
import 'package:startupmatch/widgets/icon_button.dart';
import 'package:startupmatch/widgets/listview.dart';
import 'package:startupmatch/widgets/my_appbar.dart';
import 'package:startupmatch/widgets/pitch_preview.dart';
import 'package:startupmatch/widgets/profile.dart';

class ContentProfile extends StatefulWidget {
  const ContentProfile({super.key});

  @override
  State<ContentProfile> createState() => _ContentProfileState();
}

class _ContentProfileState extends State<ContentProfile> {
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
                padding: const EdgeInsets.only(
                  top: 72,
                  bottom: 60,
                  left: 12,
                  right: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileWidget(),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Pitches:",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    const PitchPreview(
                      margin: EdgeInsets.only(top: 4),
                    ),
                    const PitchPreview(),
                    const PitchPreview(),
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
            title: "Profile".tr(),
            showShadow: showShadow,
            action: MyIconButton(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (context) => AuthPage(),
                  ),
                );
              },
              width: 28,
              height: 28,
              child: const Icon(
                CupertinoIcons.arrow_right_square,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
