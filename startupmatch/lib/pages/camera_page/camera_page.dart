import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/camera_page/confirm_media_page.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';
import 'package:startupmatch/widgets/video_time_limit.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  int selectedCameraIdx = 0;
  bool isRecording = false;
  double recordingProgress = 0.0;
  Timer? recordingTimer;
  int maxLength = 10;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.isNotEmpty) {
        _initCameraController(cameras![selectedCameraIdx]);
      }
    });
  }

  void _initCameraController(CameraDescription cameraDescription) {
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void _switchCamera() {
    if (cameras == null || cameras!.isEmpty) return;

    // Filter the cameras to get only the front and rear cameras
    List<CameraDescription> filteredCameras = cameras!.where((camera) {
      return camera.lensDirection == CameraLensDirection.front ||
          camera.lensDirection == CameraLensDirection.back;
    }).toList();

    if (filteredCameras.length < 2) return;

    // Toggle between the front and rear cameras
    selectedCameraIdx = (selectedCameraIdx + 1) % filteredCameras.length;
    _initCameraController(filteredCameras[selectedCameraIdx]);
  }

  void _startRecording() async {
    if (controller == null || !controller!.value.isInitialized || isRecording)
      return;

    try {
      await controller!.startVideoRecording();
      setState(() {
        isRecording = true;
        recordingProgress = 0.0;
      });

      recordingTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          recordingProgress += 0.001;
        });

        if (recordingProgress >= 1.0) {
          _stopRecording();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _stopRecording() async {
    if (controller == null || !controller!.value.isRecordingVideo) return;

    try {
      XFile videoFile = await controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
        recordingProgress = 0.0;
      });
      recordingTimer?.cancel();

      // Navigate to CreatePitchPage with the video path
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => ConfirmMediaPage(videoPath: videoFile.path),
        ),
      );
    } catch (e) {
      print(e);
    }
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
                  child: controller != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                value: recordingProgress,
                                color: Colors.red,
                              ),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width:
                                        controller!.value.previewSize!.height,
                                    height:
                                        controller!.value.previewSize!.width -
                                            60,
                                    child: CameraPreview(controller!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      OnTapScaleAndFade(
                        onTap: () {
                          if (controller != null) {
                            if (controller!.value.flashMode == FlashMode.torch)
                              controller!.setFlashMode(FlashMode.off);
                            else
                              controller!.setFlashMode(FlashMode.torch);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            CupertinoIcons.bolt_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      OnTapScaleAndFade(
                        onTap: isRecording ? _stopRecording : _startRecording,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          child: Icon(
                            isRecording
                                ? CupertinoIcons.stop_fill
                                : CupertinoIcons.circle_fill,
                            color: Colors.red,
                            size: 60,
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      OnTapScaleAndFade(
                        onTap: _switchCamera,
                        child: Container(
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Icon(
                            CupertinoIcons.switch_camera,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  VideoLimitWidget(time: maxLength),
                ],
              ),
            ),
            Positioned(
              right: 12,
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

  @override
  void dispose() {
    controller?.dispose();
    recordingTimer?.cancel();
    super.dispose();
  }
}
