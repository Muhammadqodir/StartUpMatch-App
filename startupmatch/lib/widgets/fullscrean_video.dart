import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreanVideoPlayer extends StatefulWidget {
  const FullScreanVideoPlayer({
    super.key,
    required this.videoUrl,
  });
  final String videoUrl;

  @override
  State<FullScreanVideoPlayer> createState() => _FullScreanVideoPlayerState();
}

class _FullScreanVideoPlayerState extends State<FullScreanVideoPlayer> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((v) {
            setState(() {
              videoPlayerController!.play();
              videoPlayerController!.setLooping(true);
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController != null
        ? VideoPlayer(videoPlayerController!)
        : const Center(
            child: CupertinoActivityIndicator(),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController!.dispose();
  }
}
