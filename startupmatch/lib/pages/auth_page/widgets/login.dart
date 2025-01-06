import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/widgets/buttons/gradient_button.dart';
import 'package:startupmatch/widgets/input.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            "login".tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: email,
            onChanged: (v) {},
            hint: "email".tr(),
            icon: CupertinoIcons.mail,
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
            isLoading: context.watch<AuthCubit>().state is LoadingAuthState,
            text: "login".tr(),
            onTap: () async {
              context.read<AuthCubit>().login(
                    email: email.text,
                    password: password.text,
                  );
            },
          ),
        ],
      ),
    );
  }
}
