import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/data/test/test_data.dart';
import 'package:startupmatch/main.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/widgets/custom_ink.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.onTap,
    required this.chatModel,
    this.margin = const EdgeInsets.all(0),
  });
  final ChatModel chatModel;
  final EdgeInsets margin;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    User me = (context.read<AuthCubit>().state as AuthorizedState).user;
    return CrossListElement(
      onPressed: () {
        onTap();
      },
      child: Padding(
        padding: margin,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    chatModel.getCompanion(me).getUserPicUrl(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/ic_launcher.png",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      );
                    },
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chatModel.getCompanion(me).fullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          if (chatModel.lastMessages.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Opacity(
                                opacity: 0.8,
                                child: Text(
                                  chatModel.getLastMessage()!.getShortTime(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (chatModel.lastMessages.isNotEmpty)
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            chatModel.getLastMessage()!.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      if (chatModel.lastMessages.isEmpty)
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            "no_messages".tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
