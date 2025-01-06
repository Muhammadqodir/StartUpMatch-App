import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/pages/update_profile_page/custom_avatar.dart';
import 'package:startupmatch/widgets/buttons/gradient_button.dart';
import 'package:startupmatch/widgets/input.dart';

class PersonalDataForm extends StatefulWidget {
  const PersonalDataForm({super.key});

  @override
  State<PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  // final TextEditingController phone = TextEditingController();
  // final TextEditingController password = TextEditingController();
  final TextEditingController about = TextEditingController();
  final TextEditingController location = TextEditingController();

  String pic = "";

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillData();
  }

  void fillData() {
    AuthorizedState state = context.read<AuthCubit>().state as AuthorizedState;
    User user = state.user;
    username.text = user.fullName;
    // phone.text = user.phone;
    // password.text = user.password;
    about.text = user.about;
    location.text = user.location;
    email.text = user.email;
    pic = user.getUserPicUrl();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthorizedState) {
          setState(() {
            pic = state.user.getUserPicUrl();
          });
          Fluttertoast.showToast(msg: "done".tr());
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            CustomAvatar(
              pic: pic,
            ),
            CustomTextField(
              controller: username,
              onChanged: (v) {},
              hint: "username".tr(),
              icon: CupertinoIcons.person,
            ),
            CustomTextField(
              controller: email,
              onChanged: (v) {},
              hint: "email".tr(),
              icon: CupertinoIcons.mail,
            ),
            CustomTextField(
              controller: location,
              onChanged: (v) {},
              hint: "location".tr(),
              icon: CupertinoIcons.map_pin_ellipse,
            ),
            CustomTextField(
              controller: about,
              minLines: 3,
              maxLines: 5,
              onChanged: (v) {},
              hint: "bio".tr(),
            ),
            // CustomTextField(
            //   controller: phone,
            //   onChanged: (v) {},
            //   disabled: true,
            //   inputFormatter: [
            //     MaskTextInputFormatter(
            //       mask: '+998 (##) ###-##-##',
            //       filter: {"#": RegExp(r'[0-9]')},
            //       type: MaskAutoCompletionType.lazy,
            //     )
            //   ],
            //   inputType: TextInputType.phone,
            //   hint: "phone".tr(),
            //   icon: CupertinoIcons.phone,
            // ),
            GradientButton(
              margin: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              text: "save".tr(),
              isLoading: isLoading,
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                Map<String, dynamic> data = {
                  "fullName": username.text,
                  "email": email.text,
                  "location": location.text,
                  "about": about.text,
                };
                await context.read<AuthCubit>().updateProfileData(data);
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
