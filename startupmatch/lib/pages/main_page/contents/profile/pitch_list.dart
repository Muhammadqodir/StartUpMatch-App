import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/my_posts_cubit.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/pages/camera_page/camera_page.dart';
import 'package:startupmatch/widgets/buttons/gradient_button.dart';
import 'package:startupmatch/widgets/empty.dart';
import 'package:startupmatch/widgets/loading.dart';
import 'package:startupmatch/widgets/post_widget/pitch_card.dart';

class MyPostsWidget extends StatelessWidget {
  const MyPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MyPostsState state = context.watch<MyPostsCubit>().state;
    if (state is SuccessMyPostsState) {
      List<Post> posts = state.myPosts;
      return posts.isNotEmpty
          ? Column(
              children: [
                const SizedBox(height: 12),
                ...posts.map(
                  (e) {
                    if (e is PitchModel) {
                      return PitchCard(
                        pitch: e,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 12),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                  width: double.infinity,
                ),
                EmptyWidget(
                  title: "list_is_empty".tr(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GradientButton(
                    text: "add_pitch".tr(),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const CameraPage(),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
    } else {
      return LoadingWidget(
        title: "loading".tr(),
      );
    }
  }
}
