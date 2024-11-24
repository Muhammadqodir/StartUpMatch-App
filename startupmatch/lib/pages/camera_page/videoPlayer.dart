import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ImagePreviewPage extends StatefulWidget {
  const ImagePreviewPage({
    super.key,
    required this.video,
  });
  final XFile video;

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    print("Video path:" + widget.video.path);
    _controller = VideoPlayerController.file(
      File.fromUri(
        Uri.parse(widget.video.path),
      ),
    )..initialize().then((v) {
        _controller.play();
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: 400,
            child: VideoPlayer(
              _controller,
            ),
          ),
          CupertinoButton(
            child: Text("play"),
            onPressed: () {
              _controller.play();
            },
          ),
          CupertinoButton(
            child: Text("mute"),
            onPressed: () {
              _controller.setVolume(1);
            },
          )
        ]),
      ),
    );
  }
}
