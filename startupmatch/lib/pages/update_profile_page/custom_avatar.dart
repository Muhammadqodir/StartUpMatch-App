import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/pages/update_profile_page/crop_image.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class CustomAvatar extends StatefulWidget {
  const CustomAvatar({
    super.key,
    required this.pic,
  });

  final String pic;

  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
  bool isLoading = false;

  Future<File> imageProviderToFile(ImageProvider imageProvider) async {
    print("Creating image");
    // Load the image
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
    final ImageStreamListener listener =
        ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    });
    stream.addListener(listener);

    final ui.Image image = await completer.future;

    // Convert the image to byte data
    final ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) ?? ByteData(0);
    final Uint8List imageData = byteData.buffer.asUint8List();
    final Uint8List compressed = await FlutterImageCompress.compressWithList(
      imageData,
      quality: 50,
    );
    // Get the temporary directory
    final Directory tempDir = await getApplicationCacheDirectory();
    final String tempPath = tempDir.path;

    // Create a file and write the image data to it
    final File file = File('$tempPath/image.png');
    await file.writeAsBytes(compressed);
    print("Created");
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: () async {
        ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            isScrollControlled: true,
            context: context,
            enableDrag: false,
            builder: (context) => CropImagePage(
              onCrop: (croppedImage) async {
                setState(() {
                  isLoading = true;
                });
                await context.read<AuthCubit>().updateProfilePic(
                      await imageProviderToFile(
                        croppedImage.image,
                      ),
                    );
                setState(() {
                  isLoading = false;
                });
              },
              image: File(image.path),
            ),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.black12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: isLoading
                ? CupertinoActivityIndicator(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    radius: 12,
                  )
                : ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/ic_launcher.png",
                      image: widget.pic,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                        "assets/ic_launcher.png",
                      ),
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              width: 26,
              height: 26,
              child: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
