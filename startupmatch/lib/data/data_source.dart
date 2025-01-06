import 'dart:io';

import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';

abstract class DataSource {
  Future<DataState<List<Post>>> fetchFeed();

  Future<DataState<List<Post>>> fetchMyPosts();

  Future<DataState<User>> login({
    required String email,
    required String password,
  });

  Future<DataState<User>> register({
    required String email,
    required String password,
    required String fullName,
    required String userType,
  });

  Future<DataState<User>> updateProfilePic({
    required File newPic,
  });

  Future<DataState<User>> updateProfileData({
    required Map<String, dynamic> data,
  });
}
