import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/main_page/contents/chat.dart';
import 'package:startupmatch/pages/main_page/contents/create.dart';
import 'package:startupmatch/pages/main_page/contents/main.dart';
import 'package:startupmatch/pages/main_page/contents/profile/profile.dart';
import 'package:startupmatch/widgets/bottom_nav.dart';
import 'package:startupmatch/widgets/fade_indexed_stack.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  bool isTransparentAppBar = true;
  bool showAppBar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeIndexedStack(
            index: selectedIndex,
            children: const [
              ContentMain(),
              ContentCreate(),
              ContentChat(),
              ContentProfile(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MyBottomNavigation(
              items: [
                NavItem(
                  "feed".tr(),
                  CupertinoIcons.rectangle_grid_1x2,
                  CupertinoIcons.rectangle_grid_1x2_fill,
                ),
                NavItem(
                  "create".tr(),
                  CupertinoIcons.add,
                  CupertinoIcons.add_circled_solid,
                ),
                NavItem(
                  "chat".tr(),
                  CupertinoIcons.chat_bubble_2,
                  CupertinoIcons.chat_bubble_2_fill,
                ),
                NavItem(
                  "profile".tr(),
                  CupertinoIcons.person,
                  CupertinoIcons.person_fill,
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                  if (index != 0) {
                    isTransparentAppBar = true;
                  } else {
                    isTransparentAppBar = false;
                  }
                  if (index == 2) {
                    showAppBar = false;
                  } else {
                    showAppBar = true;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
