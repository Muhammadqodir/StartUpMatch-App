import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/main.dart';
import 'package:startupmatch/widgets/gradient_button.dart';
import 'package:startupmatch/widgets/input.dart';
import 'package:startupmatch/widgets/select.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({super.key});
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            "register".tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: username,
            onChanged: (v) {},
            hint: "username".tr(),
            icon: CupertinoIcons.person,
          ),
          CustomTextField(
            controller: username,
            onChanged: (v) {},
            hint: "email".tr(),
            icon: CupertinoIcons.mail,
          ),
          CustomSelect(
            items: [
              "investor".tr(),
              "startuper".tr(),
            ],
            hint: "select_role".tr(),
            title: "select_role".tr(),
            onChanged: (v) {},
            icon: CupertinoIcons.smallcircle_fill_circle,
          ),
          CustomTextField(
            controller: password,
            onChanged: (v) {},
            obscureText: true,
            hint: "password".tr(),
            icon: CupertinoIcons.lock,
          ),
          GradientButton(
            margin: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            text: "register".tr(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
