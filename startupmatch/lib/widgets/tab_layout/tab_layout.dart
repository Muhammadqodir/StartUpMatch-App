import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/tab_layout/tab_bar.dart';

class TabLayout extends StatefulWidget {
  const TabLayout({
    super.key,
    required this.contents,
    required this.items,
  });

  final List<MyTabBarItem> items;
  final List<Widget> contents;

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  int selectedIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  List<GlobalKey> keys = [];
  double pageViewHeight = 100;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //setheight
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    keys = [];
    return Column(
      children: [
        MyTabBar(
          items: widget.items,
          onChange: (index) {
            _controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          },
          selectedIndex: selectedIndex,
        ),
        ExpandablePageView(
          controller: _controller,
          onPageChanged: (v) {
            setState(() {
              selectedIndex = v;
            });
          },
          children: widget.contents.map(
            (e) {
              GlobalKey key = GlobalKey();
              return Container(
                key: key,
                child: e,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
