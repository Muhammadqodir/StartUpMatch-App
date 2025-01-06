import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/upgrde_page/premuim_features.dart';
import 'package:startupmatch/pages/upgrde_page/upgrade_button.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';

const Gradient silverGradient = LinearGradient(
  colors: [Color(0xFFC0C0C0), Color(0xFF808080)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Gradient goldGradient = LinearGradient(
  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Gradient platinumGradient = LinearGradient(
  colors: [Color(0xFFE5E4E2), Color(0xFFB0B0B0)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class UpgradePage extends StatelessWidget {
  const UpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              primaryColor1,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 24,
                    width: double.infinity,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 120),
                    child: Image.asset("assets/icon_white.png"),
                  ),
                  Text(
                    "app_name".tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    child: Text(
                      "upgrade_desc".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  PremiumFeature(
                    icon: CupertinoIcons.infinite,
                    title: "premium_feature_1".tr(),
                  ),
                  PremiumFeature(
                    icon: CupertinoIcons.infinite,
                    title: "premium_feature_2".tr(),
                  ),
                  PremiumFeature(
                    icon: CupertinoIcons.infinite,
                    title: "premium_feature_3".tr(),
                  ),
                  const SizedBox(height: 12),
                  UpgradeButton(
                    title: "upgrade_to".tr(args: ["Silver"]),
                    subTitle: "price_length".tr(args: ["15", "299"]),
                    c1: silverGradient.colors.first,
                    c2: silverGradient.colors.last,
                    textColor: Colors.black87,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 6,
                    ),
                    onTap: () {
                      //realize the payment
                    },
                  ),
                  UpgradeButton(
                    title: "upgrade_to".tr(args: ["Gold"]),
                    subTitle: "price_length".tr(args: ["30", "499"]),
                    c1: goldGradient.colors.first,
                    c2: goldGradient.colors.last,
                    textColor: Colors.black87,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 6,
                    ),
                    onTap: () {
                      //realize the payment
                    },
                  ),
                  UpgradeButton(
                    title: "upgrade_to".tr(args: ["Platinum"]),
                    subTitle: "price_length".tr(args: ["60", "749"]),
                    c1: platinumGradient.colors.first,
                    c2: platinumGradient.colors.last,
                    textColor: Colors.black87,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 6,
                    ),
                    onTap: () {
                      //realize the payment
                    },
                  ),
                ],
              ),
              Positioned(
                top: 12,
                right: 12,
                child: MyIconButton(
                  width: 44,
                  height: 44,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Powered by",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Image.asset(
                        "assets/yu_money.png",
                        height: 30,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
