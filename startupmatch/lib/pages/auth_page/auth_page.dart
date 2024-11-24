import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/auth_page/widgets/login.dart';
import 'package:startupmatch/pages/auth_page/widgets/register.dart';
import 'package:startupmatch/widgets/divider.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Widget actionWidget = LoginWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 68),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    "assets/ic_launcher.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "app_name".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 24),
                ),
                const SizedBox(height: 24),
                actionWidget,
                DividerWithText(text: "or".tr()),
                MyIconButton(
                  onTap: () {
                    if (actionWidget is LoginWidget) {
                      setState(() {
                        actionWidget = RegisterWidget();
                      });
                    } else {
                      setState(() {
                        actionWidget = LoginWidget();
                      });
                    }
                  },
                  height: 70,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    actionWidget is LoginWidget
                        ? "register".tr()
                        : "login".tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 68),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
