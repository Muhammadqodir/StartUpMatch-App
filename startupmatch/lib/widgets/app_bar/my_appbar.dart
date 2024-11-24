import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.child,
    this.action = const [],
    this.showShadow = false,
  });

  final String title;
  final Widget? child;
  final List<Widget> action;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          if (showShadow)
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4), // changes position of shadow
            ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: child != null
                  ? child!
                  : Row(
                      children: [
                        const SizedBox(height: 34),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
            ),
            if (action.isNotEmpty)
              ...action.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: e,
                ),
              )
          ],
        ),
      ),
    );
  }
}