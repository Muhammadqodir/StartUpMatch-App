import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:startupmatch/pages/update_profile_page/personal_data_form.dart';
import 'package:startupmatch/widgets/app_bar/my_appbar.dart';
import 'package:startupmatch/widgets/listview.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  bool showShadow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SafeArea(
              child: MyListView(
                onTop: (v) {
                  setState(() {
                    showShadow = !v;
                  });
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 72,
                      bottom: 60,
                    ),
                    child: Column(
                      children: [
                        PersonalDataForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MyAppBar(
                title: "personal_data".tr(),
                showShadow: showShadow,
                backButton: true,
                action: const [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
