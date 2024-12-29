import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';

abstract class DataSource {
  Future<DataState<List<Post>>> fetchFeed();

  Future<DataState<List<Post>>> fetchMyPosts();

  Future<DataState<User>> login(
    String email,
    String password,
  );

  Future<DataState<User>> register(
    String email,
    String password,
    String fullName,
    String userType,
  );
}
