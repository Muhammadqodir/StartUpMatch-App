import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/spash_page.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class LangSelect extends StatelessWidget {
  const LangSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                OnTapScaleAndFade(
                  lowerBound: 0.96,
                  child: const LangItem(
                    flag: "assets/rus.png",
                    name: "Русский",
                    locale: "ru_RU",
                  ),
                  onTap: () {
                    context.setLocale(const Locale("ru", "RU"));
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const SplashPage(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                const SizedBox(height: 12),
                OnTapScaleAndFade(
                  lowerBound: 0.96,
                  child: const LangItem(
                    flag: "assets/usa.png",
                    name: "English",
                    locale: "en_US",
                  ),
                  onTap: () {
                    context.setLocale(const Locale("en", "US"));
                    Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const SplashPage(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 12,
              child: MyIconButton(
                width: 44,
                height: 44,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.black87,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LangItem extends StatelessWidget {
  const LangItem({
    super.key,
    required this.flag,
    required this.name,
    required this.locale,
  });
  final String flag;
  final String name;
  final String locale;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: context.locale.toString() == locale
                ? primaryColor
                : Colors.black12,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(6),
      width: 200,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              flag,
              width: 60,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
