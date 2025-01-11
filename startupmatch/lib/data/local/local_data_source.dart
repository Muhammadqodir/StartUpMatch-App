import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';

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

  @override
  Future<DataState<List<Post>>> fetchMyPosts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = preferences.getStringList("myPosts") ?? [];
    List<Post> posts = [];
    for (var element in list) {
      posts.add(Post.fromJson(element));
    }
    return DataState.success(data: posts);
  }

  @override
  Future<DataState<User>> login({
    required String email,
    required String password,
  }) async {
    return DataState.error(
      title: "No connection",
      message: "Please check your internet connection",
    );
  }

  @override
  Future<DataState<User>> updateProfilePic({
    required File newPic,
  }) async {
    return DataState.error(
      title: "No connection",
      message: "Please check your internet connection",
    );
  }

  @override
  Future<DataState<User>> updateProfileData({
    required Map<String, dynamic> data,
  }) async {
    return DataState.error(
      title: "No connection",
      message: "Please check your internet connection",
    );
  }

  @override
  Future<DataState<User>> register({
    required String email,
    required String password,
    required String fullName,
    required String userType,
  }) async {
    return DataState.error(
      title: "No connection",
      message: "Please check your internet connection",
    );
  }

  Future<void> saveData(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  Future<void> setIsLogin(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("isLogin", value);
  }

  Future<bool> isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("isLogin") ?? false;
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("token") ?? "undefined";
  }

  Future<User?> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJson = preferences.getString("user") ?? "undefined";
    if (userJson != "undefined") {
      print(userJson);
      return User.fromJson(userJson);
    }
    return null;
  }

  @override
  Future<DataState<User>> getMe() async {
    User? user = await getUser();
    if (user != null) {
      return DataState.success(data: user);
    } else {
      return DataState.error(
        title: "Error",
        message: "User not found",
      );
    }
  }

  @override
  Future<DataState<List<Post>>> getMyPosts() async {
    return DataState.error(title: "Error", message: "No local data");
  }
}
