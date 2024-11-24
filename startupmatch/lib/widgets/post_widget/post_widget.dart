import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/models/post/announcement.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/widgets/post_widget/announcement_widget.dart';
import 'package:startupmatch/widgets/post_widget/pitch_widget.dart';
import 'package:swipe_cards/swipe_cards.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.post,
    required this.matchEngine,
  });

  final Post post;
  final MatchEngine matchEngine;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.post is PitchModel) {
      return PitchWidget(
        pitch: widget.post as PitchModel,
        matchEngine: widget.matchEngine,
      );
    } else if (widget.post is AnnouncementModel) {
      return AnnouncementWidget(
        announcement: widget.post as AnnouncementModel,
        matchEngine: widget.matchEngine,
      );
    }
    return const Text("Undefined post type");
  }
}
