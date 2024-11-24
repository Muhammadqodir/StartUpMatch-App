import 'package:shared_preferences/shared_preferences.dart';

import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/post/post.dart';

class LocalDataSource implements DataSource {
  @override
  Future<DataState<List<Post>>> fetchFeed() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = preferences.getStringList("feed") ?? [];
    List<Post> posts = [];
    for (var element in list) {
      posts.add(Post.fromJson(element));
    }
    return DataState.success(data: posts);
  }
}
