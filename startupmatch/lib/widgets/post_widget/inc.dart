import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/main.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/pages/chat_page/chat_page.dart';
import 'package:startupmatch/widgets/buttons/flat_button.dart';

class UserTitle extends StatelessWidget {
  const UserTitle({
    super.key,
    required this.user,
    this.isList = false,
    this.showFollow = true,
    this.margin = const EdgeInsets.all(0),
  });
  final User user;
  final bool isList;
  final bool showFollow;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    User me = (context.read<AuthCubit>().state as AuthorizedState).user;
    return Padding(
      padding: margin,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              user.getUserPicUrl(),
              errorBuilder: (context, error, stackTrace) => Image.asset(
                "assets/ic_launcher.png",
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isList
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                spreadRadius: 1,
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            fontWeight: FontWeight.w900,
                          ),
                ),
                Text(
                  user.email,
                  style: isList
                      ? Theme.of(context).textTheme.titleSmall
                      : Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                spreadRadius: 1,
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            fontWeight: FontWeight.w900,
                          ),
                ),
              ],
            ),
          ),
          if (me.id != user.id && showFollow)
            SizedBox(
              width: 120,
              height: 60,
              child: FlatButton(
                padding: const EdgeInsets.all(0),
                title: "message".tr(),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => ChatPage(
                      model: ChatModel(
                        user: user,
                        user1:
                            (context.read<AuthCubit>().state as AuthorizedState)
                                .user,
                        lastMessages: [],
                      ),
                    ),
                  ));
                },
              ),
            ),
        ],
      ),
    );
  }
}

class ExpandDescription extends StatefulWidget {
  const ExpandDescription({
    super.key,
    required this.text,
    this.lines = 2,
    this.color = Colors.white,
  });
  final Color color;
  final String text;
  final int lines;

  @override
  State<ExpandDescription> createState() => _ExpandDescriptionState();
}

class _ExpandDescriptionState extends State<ExpandDescription> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          showDragHandle: true,
          context: context,
          builder: (context) => Column(
            children: [
              Text(widget.text),
            ],
          ),
        );
      },
      child: Text(
        widget.text,
        maxLines: widget.lines,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: widget.color,
            ),
      ),
    );
  }
}
