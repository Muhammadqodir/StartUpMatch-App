import 'package:flutter/cupertino.dart';

class MessagesListView extends StatelessWidget {
  MessagesListView({
    super.key,
    required this.children,
    required this.onTop,
    required this.controller,
  });

  final ScrollController controller;
  final List<Widget> children;
  final Function(bool) onTop;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (controller.position.pixels == notification.metrics.pixels) {
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
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: children,
      ),
    );
  }
}
