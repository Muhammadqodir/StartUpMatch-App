import 'package:flutter/material.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class FlatButton extends StatelessWidget {
  const FlatButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color = primaryColor,
    this.preffix,
    this.suffix,
    this.margin = const EdgeInsets.all(12),
    this.padding = const EdgeInsets.all(12),
  });

  final String title;
  final Function onTap;
  final Color color;
  final IconData? preffix;
  final IconData? suffix;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      lowerBound: 0.96,
      onTap: () {
        onTap();
      },
      child: Container(
        padding: padding,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (preffix != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  preffix,
                  color: Colors.white,
                ),
              ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            if (suffix != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  suffix,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
