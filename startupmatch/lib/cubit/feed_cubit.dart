import 'package:bloc/bloc.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:swipe_cards/swipe_cards.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial());

  Future<void> fetchFeed() async {
    emit(FeedLoading());
    DataState<List<Post>> posts =
        await (await getIt.getAsync<DataSource>()).fetchFeed();
    if (posts.isSuccess) {
      emit(FeedSuccess(posts: posts.data!, currentIndex: 0));
    }
  }

  void likePitch(int postId) async {
    await (await getIt.getAsync<DataSource>()).likePitch(
      postId: postId,
      action: "like",
    );
  }

  void addView(int postId) async {
    await (await getIt.getAsync<DataSource>()).addView(postId: postId);
  }

  void dislikePitch(int postId) async {
    await (await getIt.getAsync<DataSource>()).likePitch(
      postId: postId,
      action: "dislike",
    );
  }

  void setCurrentIndex(int index) {
    if (state is FeedSuccess) {
      emit((state as FeedSuccess).copyWith(currentIndex: index));
    }
  }
}
