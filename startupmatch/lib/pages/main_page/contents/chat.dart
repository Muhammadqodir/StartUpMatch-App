import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/data/test/test_data.dart';
import 'package:startupmatch/pages/chat_page/chat_page.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/chat/chat_item.dart';
import 'package:startupmatch/widgets/listview.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';

class ContentChat extends StatefulWidget {
  const ContentChat({super.key});

  @override
  State<ContentChat> createState() => _ContentChatState();
}

class _ContentChatState extends State<ContentChat> {
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
                  top: 60,
                  bottom: 60,
                ),
                child: Column(
                  children: List<Widget>.filled(
                    3,
                    ChatItem(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => ChatPage(
                              model: TestData.testChatModel,
                            ),
                          ),
                        );
                      },
                      chatModel: TestData.testChatModel,
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                    ),
                  ),
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
            title: "chat".tr(),
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
