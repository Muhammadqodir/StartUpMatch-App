import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/models/chat/chat_message.dart';
import 'package:startupmatch/utils/themes.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    bool isMy = message.isMy();
    return Row(
      mainAxisAlignment: isMy ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200,
            maxWidth: 250,
          ),
          child: Container(
            alignment: isMy ? Alignment.centerRight : Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 12,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMy ? primaryColor : Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMy ? 24 : 5),
                topRight: Radius.circular(isMy ? 5 : 24),
                bottomLeft: const Radius.circular(24),
                bottomRight: const Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "test",
                    textAlign: isMy ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: isMy ? Colors.white : Colors.black54,
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isMy)
                      Icon(
                        message.isRead() ? Icons.done_all : Icons.done,
                        size: 18,
                        color: isMy ? Colors.white : Colors.black54,
                      ),
                    const SizedBox(width: 4),
                    Text(
                      "20:20",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: isMy ? Colors.white : Colors.black54,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
