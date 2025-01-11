import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/auth_cubit.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/widgets/empty.dart';
import 'package:startupmatch/widgets/post_widget/pitch_card.dart';

class MyPostsWidget extends StatelessWidget {
  const MyPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthState state = context.watch<AuthCubit>().state;
    if (state is AuthorizedState) {
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
          : const EmptyWidget(
              title: "List is empty!",
            );
    }else{
      return const SizedBox();
    }
  }
}
