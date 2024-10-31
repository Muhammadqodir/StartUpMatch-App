import 'package:flutter/cupertino.dart';

class MyListView extends StatelessWidget {
  const MyListView({
    super.key,
    required this.children,
    required this.onTop,
  });

  final List<Widget> children;
  final Function(bool) onTop;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels > 0) {
          onTop(false);
        }
        if (notification.metrics.pixels <= 0) {
          onTop(true);
        }
        return true;
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: children,
      ),
    );
  }
}
