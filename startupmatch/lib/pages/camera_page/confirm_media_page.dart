import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/camera_page/camera_page.dart';
import 'package:startupmatch/pages/create_page/create_pitch_page.dart';
import 'package:startupmatch/widgets/buttons/base_button.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/video_time_limit.dart';
import 'package:video_player/video_player.dart';

class ConfirmMediaPage extends StatefulWidget {
  const ConfirmMediaPage({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  State<ConfirmMediaPage> createState() => _ConfirmMediaPageState();
}

class _ConfirmMediaPageState extends State<ConfirmMediaPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
        _videoController.setLooping(true);
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _videoController.value.isInitialized
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BaseButton(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                              builder: (context) => const CameraPage(),
                            ),
                          );
                        },
                        child: Text(
                          "retake".tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BaseButton(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                              builder: (context) => CreatePitchPage(
                                videoPath: widget.videoPath,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "confirm".tr(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            const Icon(CupertinoIcons.right_chevron)
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  VideoLimitWidget(time: 10),
                ],
              ),
            ),
            Positioned(
              left: 12,
              top: 16,
              child: MyIconButton(
                width: 40,
                height: 40,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  CupertinoIcons.xmark,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
