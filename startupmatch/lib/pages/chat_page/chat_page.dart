import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/data/test/test_data.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/pages/chat_page/widgets/input_field.dart';
import 'package:startupmatch/pages/chat_page/widgets/message_widget.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/listview.dart';
import 'package:startupmatch/widgets/post_widget/inc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.model,
  });
  final ChatModel model;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool showShadow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 60,
              ),
              child: MyListView(
                onTop: (v) {
                  setState(() {
                    showShadow = !v;
                  });
                },
                children: widget.model.lastMessages
                    .map(
                      (e) => MessageWidget(message: e),
                    )
                    .toList(),
              ),
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
                // MyIconButton(
                //   onTap: () {},
                //   width: 28,
                //   height: 28,
                //   child: const Icon(
                //     CupertinoIcons.bell,
                //     size: 28,
                //   ),
                // ),
              ],
              child: Row(
                children: [
                  MyIconButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    width: 28,
                    height: 28,
                    child: const Icon(
                      CupertinoIcons.back,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: UserTitle(
                      user: widget.model.getCompanion(
                        TestData.testUser,
                      ),
                      isList: true,
                      showFollow: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ChatInputField(),
          ),
        ],
      ),
    );
  }
}
