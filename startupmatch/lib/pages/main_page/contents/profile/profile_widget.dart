import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/pages/spash_page.dart';
import 'package:startupmatch/pages/update_profile_page/update_profile_page.dart';
import 'package:startupmatch/widgets/buttons/tap_scale.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UnAuthorizedState) {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => const SplashPage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthorizedState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBAE8F9),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/ic_launcher.png",
                        image: state.user.getUserPicUrl(),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/ic_launcher.png",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          state.user.email,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  OnTapScaleAndFade(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const UpdateProfilePage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(24),
                        ),
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      child: const Icon(
                        CupertinoIcons.pen,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (state.user.location != "")
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                        const SizedBox(width: 1),
                        Text(
                          state.user.location,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  const Icon(
                    CupertinoIcons.calendar,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "joined".tr(args: [state.user.getJoinedDate()]),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              if (state.user.about != "")
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    state.user.about,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
