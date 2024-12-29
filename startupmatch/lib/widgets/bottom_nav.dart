import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({
    super.key,
    this.selected = 0,
    required this.items,
    required this.onTap,
  });

  final List<NavItem> items;
  final int selected;
  final Function(int) onTap;

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -4), // changes position of shadow
          ),
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: widget.items
              .map(
                (e) => Expanded(
                  child: OnTapScaleAndFade(
                    onTap: () {
                      widget.onTap(widget.items.indexOf(e));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          widget.selected == widget.items.indexOf(e)
                              ? e.iconSelect
                              : e.icon,
                          color: widget.selected == widget.items.indexOf(e)
                              ? primaryColor
                              : Theme.of(context).textTheme.bodyMedium!.color,
                          size: widget.selected == widget.items.indexOf(e)
                              ? 26
                              : 24,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        widget.selected == widget.items.indexOf(e)
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: primaryColor,
                                ),
                                height: 4,
                                width: 4,
                              )
                            : const SizedBox(height: 4)
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class NavItem {
  String title;
  IconData icon;
  IconData iconSelect;
  NavItem(
    this.title,
    this.icon,
    this.iconSelect,
  );
}
