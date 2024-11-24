import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startupmatch/cubit/feed_cubit.dart';
import 'package:startupmatch/models/post/pitch.dart';

class MyPostsWidget extends StatelessWidget {
  const MyPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: context.watch<FeedCubit>().state.posts.map(
        (e) {
          if (e is PitchModel) {
            return Text((e as PitchModel).title);
          }
          return SizedBox();
        },
      ).toList(),
    );
  }
}
