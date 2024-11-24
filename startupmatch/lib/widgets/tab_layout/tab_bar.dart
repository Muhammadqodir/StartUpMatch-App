import 'package:flutter/material.dart';
import 'package:startupmatch/utils/extentions.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.items,
    required this.onChange,
    required this.selectedIndex,
  });

  final List<MyTabBarItem> items;
  final Function(int) onChange;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: items
            .map(
              (e) => Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: items.indexOf(e) == selectedIndex
                            ? primaryColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: OnTapScaleAndFade(
                    child: e,
                    onTap: () {
                      onChange(items.indexOf(e));
                    },
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class MyTabBarItem extends StatelessWidget {
  const MyTabBarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
  });

  final IconData icon;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            count.beautify(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
