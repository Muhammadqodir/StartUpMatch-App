import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/post/post.dart';

abstract class DataSource {
  Future<DataState<List<Post>>> fetchFeed();
}
