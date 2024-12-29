import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/widgets/buttons/gradient_button.dart';
import 'package:startupmatch/widgets/input.dart';
import 'package:startupmatch/widgets/buttons/radio.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({super.key});
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String role = "startup";
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
            controller: email,
            onChanged: (v) {},
            hint: "email".tr(),
            icon: CupertinoIcons.mail,
          ),
          RadioButton(
            items: [
              "investor".tr(),
              "startuper".tr(),
            ],
            hint: "select_role".tr(),
            onChange: (v) {
              role = v;
            },
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
            isLoading: context.watch<AuthCubit>().state is LoadingAuthState,
            onTap: () {
              context.read<AuthCubit>().register(
                    username.text,
                    password.text,
                    email.text,
                    role,
                  );
            },
          ),
        ],
      ),
    );
  }
}
