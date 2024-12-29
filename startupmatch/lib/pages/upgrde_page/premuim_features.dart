import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PremiumFeature extends StatelessWidget {
  const PremiumFeature({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.checkmark_alt_circle_fill,
            size: 24,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white, fontFamily: "PoppinsBold"),
          )
        ],
      ),
    );
  }
}
