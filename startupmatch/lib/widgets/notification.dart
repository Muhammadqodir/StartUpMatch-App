import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/models/notification.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.model,
  });

  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                model.icon,
                width: 38,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    model.content,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
