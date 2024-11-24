import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.height = 50,
    this.isLoading = false,
    this.margin = const EdgeInsets.all(0),
    this.lowerBound = 0.95,
  });

  final String text;
  final Function() onTap;
  final double width;
  final double height;
  final EdgeInsets margin;
  final bool isLoading;
  final double lowerBound;

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: onTap,
      lowerBound: lowerBound,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              primaryColor,
              primaryColor1,
            ],
          ),
        ),
        child: isLoading
            ? const CupertinoActivityIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontFamily: "PoppinsBold",
                    ),
              ),
      ),
    );
  }
}
