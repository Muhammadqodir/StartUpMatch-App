import 'package:bloc/bloc.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:swipe_cards/swipe_cards.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedState(posts: []));

  Future<void> fetchFeed() async {
    emit(state.copyWith(isLoading: true));
    DataState<List<Post>> posts = await getIt<DataSource>().fetchFeed();
    if (posts.isSuccess) {
      emit(state.copyWith(posts: posts.data, currentIndex: 0));
    }
    emit(state.copyWith(isLoading: false));
  }

  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
