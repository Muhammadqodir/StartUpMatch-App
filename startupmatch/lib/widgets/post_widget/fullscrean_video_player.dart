import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';
import 'package:video_player/video_player.dart';

class FullScreanVideoPlayer extends StatefulWidget {
  const FullScreanVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  final String videoUrl;
  final String title;

  @override
  State<FullScreanVideoPlayer> createState() => _FullScreanVideoPlayerState();
}

class _FullScreanVideoPlayerState extends State<FullScreanVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl,
      ),
    )..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              title: widget.title,
              backButton: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                child: Center(
                  child: _controller.value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
