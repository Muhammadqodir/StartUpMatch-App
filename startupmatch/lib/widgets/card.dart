import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.title,
    required this.child,
    this.soonBadge = false,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(18),
  });

  final String title;
  final Widget child;
  final bool soonBadge;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: soonBadge ? 0.5 : 1,
      child: Container(
        width: double.infinity,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.30),
              spreadRadius: 1,
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: padding.top,
                  left: padding.left,
                  right: padding.right,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    soonBadge
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF95DBF6),
                                  Color(0xFF11B1EE),
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Soon",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
