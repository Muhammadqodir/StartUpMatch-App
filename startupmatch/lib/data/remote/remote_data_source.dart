// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/post/post.dart';

class RemoteDataSource implements DataSource {
  String token;
  RemoteDataSource({
    required this.token,
  });

  @override
  Future<DataState<List<Post>>> fetchFeed() async {
    List<Post> res = [];
    return DataState.success(data: res);
  }
}
