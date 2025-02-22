import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/chat/chat_message.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/models/notification.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';

abstract class DataSource {
  Future<DataState<List<Post>>> fetchFeed();

  Future<DataState<List<ChatModel>>> fetchMyChats();

  Future<DataState<List<ChatMessage>>> sendMessage(
      {required int cUserId, required String text, File? attachment});

  Future<DataState<List<ChatMessage>>> fetchMessages(int counterpartUserId);

  Future<void> likePitch({
    required int postId,
    required String action,
  });

  Future<void> addView({
    required int postId,
  });

  Future<List<NotificationModel>> getNotifications();

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

  Future<DataState<List<Post>>> getMyPosts();

  Future<DataState<User>> getMe();

  Future<DataState<bool>> removePitch(int id);
}
