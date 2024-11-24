import 'package:flutter/cupertino.dart';

class MyListView extends StatelessWidget {
  MyListView({
    super.key,
    required this.children,
    required this.onTop,
  });

  final ScrollController _controller = ScrollController();
  final List<Widget> children;
  final Function(bool) onTop;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (_controller.position.pixels == notification.metrics.pixels) {
          if (notification.metrics.pixels > 0) {
            onTop(false);
          }
          if (notification.metrics.pixels <= 0) {
            onTop(true);
          }
        }

        return true;
      },
      child: ListView(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: children,
      ),
    );
  }
}
