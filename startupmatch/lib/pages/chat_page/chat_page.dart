import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/cubit/message_cubit.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/pages/chat_page/widgets/input_field.dart';
import 'package:startupmatch/pages/chat_page/widgets/listview.dart';
import 'package:startupmatch/pages/chat_page/widgets/message_widget.dart';
import 'package:startupmatch/utils/dialogs.dart';
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

  final ScrollController _controller = ScrollController();
  void _scrollToBottom() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_controller.hasClients) {
        _controller.jumpTo(
          _controller.position.maxScrollExtent,
          // duration: const Duration(milliseconds: 200),
          // curve: Curves.bounceIn,
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() {
    context.read<MessageCubit>().fetchMessages(
          widget.model
              .getCompanion(
                  (context.read<AuthCubit>().state as AuthorizedState).user)
              .id,
        );
  }

  @override
  Widget build(BuildContext context) {
    User me = (context.read<AuthCubit>().state as AuthorizedState).user;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 60,
              ),
              child: BlocBuilder<MessageCubit, MessageState>(
                builder: (context, state) {
                  if (state is MessageSuccess || state is MessageSendingState) {
                    return MessagesListView(
                        controller: _controller,
                        onTop: (v) {
                          setState(() {
                            showShadow = !v;
                          });
                        },
                        children: [
                          ...(state as MessageSuccess)
                              .messages
                              .map(
                                (e) => MessageWidget(message: e),
                              )
                              .toList(),
                          const SizedBox(height: 12),
                        ]);
                  }

                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
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
                //   onTap: () {
                //     _scrollToBottom();
                //   },
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
                      user: widget.model.getCompanion(me),
                      showFollow: false,
                      isList: true,
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
            child: BlocListener<MessageCubit, MessageState>(
                listener: (context, state) {
              if (state is MessageError) {
                showAlertDialog(context: context, title: state.title, message: state.message);
              }
              if (state is MessageSuccess) {
                print("scrollToBottom");
                _scrollToBottom();
              }
            }, child: BlocBuilder<MessageCubit, MessageState>(
              builder: (context, state) {
                return ChatInputField(
                  cUserId: widget.model.getCompanion(me).id,
                  showLoading: state is MessageSendingState,
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
