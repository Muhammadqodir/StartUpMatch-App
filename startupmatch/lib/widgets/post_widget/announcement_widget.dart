import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/models/post/announcement.dart';
import 'package:startupmatch/widgets/buttons/flat_button.dart';
import 'package:startupmatch/widgets/post_widget/inc.dart';
import 'package:swipe_cards/swipe_cards.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({
    super.key,
    required this.announcement,
    required this.matchEngine,
  });

  final AnnouncementModel announcement;
  final MatchEngine matchEngine;

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.network(
              widget.announcement.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(200),
                    Colors.black.withAlpha(0),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserTitle(user: widget.announcement.owner),
                  const SizedBox(height: 6),
                  FlatButton(
                    title: widget.announcement.btnTitle,
                    onTap: () {},
                    suffix: CupertinoIcons.arrow_up_right,
                    margin: const EdgeInsets.only(bottom: 6),
                  ),
                  ExpandDescription(
                    text: widget.announcement.content,
                    lines: 4,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
