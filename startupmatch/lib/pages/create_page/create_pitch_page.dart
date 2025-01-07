import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startupmatch/cubit/createpost_cubit.dart';
import 'package:startupmatch/utils/dialogs.dart';
import 'package:startupmatch/utils/themes.dart';
import 'package:startupmatch/widgets/buttons/icon_button.dart';
import 'package:startupmatch/widgets/input.dart';

class CreatePitchPage extends StatefulWidget {
  const CreatePitchPage({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  State<CreatePitchPage> createState() => _CreatePitchPageState();
}

class _CreatePitchPageState extends State<CreatePitchPage> {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: (context, state) {
        if (state is CreatePostError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showAlertDialog(
              context: context,
              title: state.title,
              message: state.message,
            );
          });
        } else if (state is CreatePostSuccess) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: "post_created".tr(),
          );
        }
      },
      child: Scaffold(
        floatingActionButton: MyIconButton(
          width: 64,
          height: 64,
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            await context.read<CreatePostCubit>().createPitch(
                  title: "test",
                  description: controller.text,
                  video: File.fromUri(
                    Uri.parse(widget.videoPath),
                  ),
                );
            setState(() {
              isLoading = false;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [primaryColor, primaryColor1],
              ),
              boxShadow: const [defaiultShadow],
              borderRadius: BorderRadius.circular(40),
            ),
            child: isLoading
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 16,
                  )
                : const Icon(
                    CupertinoIcons.arrow_right,
                    size: 32,
                    color: Colors.white,
                  ),
          ),
        ),
        body: ListView(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    MyIconButton(
                      width: 35,
                      height: 35,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        CupertinoIcons.arrow_left_circle_fill,
                        color: Colors.black87,
                        size: 35,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "publish_pitch".tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    CustomTextField(
                      margin: const EdgeInsets.only(top: 12),
                      controller: controller,
                      minLines: 4,
                      maxLines: 60,
                      autoFocus: true,
                      onChanged: (v) {},
                      hint: "description".tr(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
