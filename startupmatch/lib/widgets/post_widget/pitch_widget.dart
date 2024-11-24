import 'package:flutter/material.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/widgets/post_widget/inc.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:video_player/video_player.dart';

class PitchWidget extends StatefulWidget {
  const PitchWidget({
    super.key,
    required this.pitch,
    required this.matchEngine,
  });

  final PitchModel pitch;
  final MatchEngine matchEngine;

  @override
  State<PitchWidget> createState() => _PitchWidgetState();
}

class _PitchWidgetState extends State<PitchWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.pitch.videoUrl,
      ),
    )..initialize().then((_) {
        if (widget.matchEngine.currentItem!.content == widget.pitch) {
          _controller!.play();
          _controller!.setLooping(true);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
            child: _controller != null
                ? GestureDetector(
                    onTap: () {
                      // _controller!.play();
                      // _controller!.setLooping(true);
                      // print("Playing");
                    },
                    child: VideoPlayer(_controller!),
                  )
                : const SizedBox(),
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
                  UserTitle(user: widget.pitch.owner),
                  const SizedBox(height: 6),
                  ExpandDescription(text: widget.pitch.description)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
