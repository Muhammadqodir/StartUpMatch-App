import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/data/test/test_data.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/pages/lang_page.dart';
import 'package:startupmatch/pages/main_page/contents/profile/pitch_list.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/listview.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';
import 'package:startupmatch/pages/main_page/contents/profile/profile_widget.dart';
import 'package:startupmatch/widgets/post_widget/inc.dart';
import 'package:startupmatch/widgets/tab_layout/tab_bar.dart';
import 'package:startupmatch/widgets/tab_layout/tab_layout.dart';

class ContentProfile extends StatefulWidget {
  const ContentProfile({super.key});

  @override
  State<ContentProfile> createState() => _ContentProfileState();
}

class _ContentProfileState extends State<ContentProfile> {
  bool showShadow = false;

  @override
  Widget build(BuildContext context) {
    AuthState state = context.watch<AuthCubit>().state;
    return Stack(
      children: [
        SafeArea(
          child: MyListView(
            onTop: (v) {
              setState(() {
                showShadow = !v;
              });
            },
            children: const [
              Padding(
                padding: const EdgeInsets.only(
                  top: 72,
                  bottom: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: ProfileWidget(),
                    ),
                    MyPostsWidget(),
                    // TabLayout(
                    //   items: [
                    //     MyTabBarItem(
                    //       icon: CupertinoIcons.rectangle_grid_2x2,
                    //       title: "pitches".tr(),
                    //       count: state is AuthorizedState
                    //           ? state.myPosts.length
                    //           : 0,
                    //     ),
                    //     MyTabBarItem(
                    //       icon: CupertinoIcons.rectangle_stack_person_crop_fill,
                    //       title: "likes".tr(),
                    //       count: 234,
                    //     ),
                    //   ],
                    //   contents: [
                    //     const MyPostsWidget(),
                    //     Column(
                    //       children: List<User>.filled(6, TestData.testUser)
                    //           .map(
                    //             (e) => UserTitle(
                    //               user: TestData.testUser,
                    //               isList: true,
                    //               margin: const EdgeInsets.symmetric(
                    //                 vertical: 6,
                    //                 horizontal: 12,
                    //               ),
                    //             ),
                    //           )
                    //           .toList(),
                    //     ),
                    //   ],
                    // )
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
            title: "profile".tr(),
            showShadow: showShadow,
            action: [
              // MyIconButton(
              //   onTap: () {
              //     //Open news page
              //   },
              //   width: 28,
              //   height: 28,
              //   child: const Icon(
              //     CupertinoIcons.text_badge_star,
              //     size: 28,
              //   ),
              // ),
              MyIconButton(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const LangSelect(),
                    ),
                  );
                },
                width: 28,
                height: 28,
                child: const Icon(
                  CupertinoIcons.globe,
                  size: 28,
                ),
              ),
              MyIconButton(
                onTap: () async {
                  await context.read<AuthCubit>().logout();
                },
                width: 28,
                height: 28,
                child: const Icon(
                  CupertinoIcons.arrow_right_square,
                  size: 28,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
