import 'package:bloc/bloc.dart';
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/di/di.dart';
import 'package:startupmatch/models/post/post.dart';

part 'my_posts_state.dart';

class MyPostsCubit extends Cubit<MyPostsState> {
  MyPostsCubit() : super(InitialMyPostsState());

  Future<void> getMyPosts() async {
    emit(LoadingMyPostsState());
    DataSource dataSource = await getIt.getAsync<DataSource>();
    DataState<List<Post>> myPosts = await dataSource.getMyPosts();
    if (myPosts.isSuccess) {
      emit(SuccessMyPostsState(myPosts: myPosts.data!));
    } else {
      emit(ErrorMyPostsState(title: myPosts.title, message: myPosts.message));
    }
  }

  Future<void> removePost(int id) async {
    DataSource dataSource = await getIt.getAsync<DataSource>();
    await dataSource.removePitch(id);
    getMyPosts();
  }
}
