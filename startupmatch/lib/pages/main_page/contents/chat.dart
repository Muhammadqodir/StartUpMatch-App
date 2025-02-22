import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startupmatch/cubit/chat_cubit.dart';
import 'package:startupmatch/pages/chat_page/chat_page.dart';
import 'package:startupmatch/pages/notifications_page/notifications_page.dart';
import 'package:startupmatch/utils/dialogs.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/chat/chat_item.dart';
import 'package:startupmatch/widgets/empty.dart';
import 'package:startupmatch/widgets/listview.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';
import 'package:startupmatch/widgets/loading.dart';

class ContentChat extends StatefulWidget {
  const ContentChat({super.key});

  @override
  State<ContentChat> createState() => _ContentChatState();
}

class _ContentChatState extends State<ContentChat> {
  bool showShadow = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    context.read<ChatCubit>().fetchChats();
  }

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
                child: BlocListener<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if (state is ChatError) {
                      showAlertDialog(
                        context: context,
                        title: state.title,
                        message: state.message,
                      );
                    }
                  },
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoading || state is ChatInitial) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: LoadingWidget(
                            title: "loading".tr(),
                          ),
                        );
                      }
                      if (state is ChatError) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: LoadingWidget(
                            title: state.title + "\n " + state.message,
                          ),
                        );
                      }
                      if (state is ChatSuccess) {
                        return state.chats.isNotEmpty
                            ? Column(
                                children: state.chats
                                    .map(
                                      (e) => ChatItem(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (context) => ChatPage(
                                                model: e,
                                              ),
                                            ),
                                          );
                                        },
                                        chatModel: e,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 12,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            : Center(
                                child: EmptyWidget(title: "no_chats".tr()),
                              );
                      }
                      return const SizedBox();
                    },
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
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const NotificationsPage(),
                    ),
                  );
                },
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
