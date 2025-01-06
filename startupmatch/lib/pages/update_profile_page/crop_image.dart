import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/widgets/buttons/gradient_button.dart';

class CropImagePage extends StatefulWidget {
  const CropImagePage({
    super.key,
    required this.image,
    required this.onCrop,
  });
  final File image;
  final Function(Image) onCrop;

  @override
  State<CropImagePage> createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  double containerHeight = 200;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateContainerHeight();
  }

  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  void calculateContainerHeight() async {
    var decodedImage =
        await decodeImageFromList(widget.image.readAsBytesSync());
    double screanWidth = MediaQuery.of(context).size.width;
    double diff = screanWidth / decodedImage.width;
    setState(() {
      containerHeight = (decodedImage.height * diff) +
          69 +
          MediaQuery.of(context).padding.bottom;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          child: Column(
            children: [
              Expanded(
                child: CropImage(
                  alwaysMove: false,
                  controller: controller,
                  image: Image.file(widget.image),
                  gridColor: Theme.of(context).scaffoldBackgroundColor,
                  gridInnerColor: Theme.of(context).scaffoldBackgroundColor,
                  gridCornerColor: Theme.of(context).scaffoldBackgroundColor,
                  gridCornerSize: 50,
                  gridThinWidth: 1,
                  gridThickWidth: 4,
                  scrimColor:
                      Theme.of(context).scaffoldBackgroundColor.withAlpha(
                            100,
                          ),
                  alwaysShowThirdLines: true,
                  onCrop: (rect) => print(rect),
                  minimumImageSize: 50,
                ),
              ),
              GradientButton(
                height: 45,
                margin: const EdgeInsets.all(12),
                onTap: () async {
                  widget.onCrop(await controller.croppedImage());
                  Navigator.of(context).pop();
                },
                text: "cut".tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
