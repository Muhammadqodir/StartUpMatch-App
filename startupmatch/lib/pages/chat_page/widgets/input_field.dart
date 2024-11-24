import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/input.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -4), // changes position of shadow
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            MyIconButton(
              width: 40,
              height: 40,
              onTap: () {},
              child: const Icon(
                CupertinoIcons.add,
                size: 32,
              ),
            ),
            Expanded(
              child: CustomTextField(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                controller: _controller,
                onChanged: (v) {},
              ),
            ),
            MyIconButton(
              width: 40,
              height: 40,
              onTap: () {},
              child: const Icon(
                CupertinoIcons.paperplane,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}