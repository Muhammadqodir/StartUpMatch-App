import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startupmatch/pages/camera_page/videoPlayer.dart';
import 'package:startupmatch/utils/themes.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(
      _cameras[0],
      ResolutionPreset.medium,
    );
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            Fluttertoast.showToast(msg: "CameraAccessDenied");
            break;
          default:
            Fluttertoast.showToast(msg: "Other error: ${e.code}");
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool isLoading = false;

  XFile? capturedImage;

  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final xScale = (controller?.value.aspectRatio ?? 1) / deviceRatio;
    final double yScale = 1;

    return Scaffold(
      body: controller != null
          ? Stack(
              children: [
                AspectRatio(
                  aspectRatio: deviceRatio,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.diagonal3Values(xScale, yScale, 1),
                    child: CameraPreview(
                      controller!,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: CupertinoButton(
                    onPressed: () async {
                      if (!isRecording) {
                        await controller!.prepareForVideoRecording();
                        await controller!.startVideoRecording();
                        setState(() {
                          isRecording = true;
                        });
                      } else {
                        XFile video = await controller!.stopVideoRecording();
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) =>
                                ImagePreviewPage(video: video),
                          ),
                        );
                      }
                    },
                    color: primaryColor,
                    child: !isRecording
                        ? Icon(
                            CupertinoIcons.video_camera,
                            color: Colors.white,
                          )
                        : Icon(
                            CupertinoIcons.stop_circle,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CupertinoActivityIndicator(),
            ),
    );
  }
}
