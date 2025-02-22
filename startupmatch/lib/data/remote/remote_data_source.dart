// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:http/http.dart' as http;
import 'package:startupmatch/data/remote/http_client.dart';
import 'package:startupmatch/models/chat/chat_message.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/models/notification.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';

const String serverBaseUrl = "https://sandbox.alfocus.uz/startup-match/";
const String baseUrl = "https://sandbox.alfocus.uz/startup-match/api/v1/";

class RemoteDataSource implements DataSource {
  String token;
  late MyHttpClient client;

  RemoteDataSource({
    required this.token,
  }) {
    client = MyHttpClient(
      token: token,
      baseUrl: baseUrl,
      lang: 'ru',
    );
  }

  @override
  Future<DataState<List<PitchModel>>> fetchFeed() async {
    try {
      http.Response res = await client.get("getFeed");
      if (res.statusCode == 200) {
        List<PitchModel> list = [];
        print("Feed: " + res.body);
        Map<String, dynamic> data = jsonDecode(res.body);

        for (var element in data["data"]) {
          list.add(PitchModel.fromMap(element));
        }
        return DataState.success(data: list);
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data.toString(),
          title: "Error",
        );
      }
    } catch (e, s) {
      print(e);
      print(s);
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<void> addView({
    required int postId,
  }) async {
    try {
      http.Response res = await client.get("addView?pitchId=$postId");
      print(res.body);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  Future<void> likePitch({
    required int postId,
    required String action,
  }) async {
    try {
      http.Response res = await client.post("addLike", body: {
        "pitchId": postId.toString(),
        "action": action,
      });
      print(res.body);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  Future<DataState<List<PitchModel>>> fetchMyPosts() async {
    try {
      http.Response res = await client.get("getMyPitches");
      if (res.statusCode == 200) {
        List<PitchModel> list = [];
        Map<String, dynamic> data = jsonDecode(res.body);

        for (var element in data["data"]) {
          list.add(PitchModel.fromMap(element));
        }
        return DataState.success(data: list);
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data.toString(),
          title: "Error",
        );
      }
    } catch (e, s) {
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await client.post("login", body: {
        "email": email,
        "password": password,
      });
      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.success(data: User.fromMap(data["data"]));
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<User>> updateProfileData({
    required Map<String, dynamic> data,
  }) async {
    try {
      http.Response res = await client.post("updateAccount", body: data);
      print(res.body);
      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.success(data: User.fromMap(data["data"]));
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<List<Post>>> getMyPosts() async {
    try {
      http.Response res = await client.get("getMyPitches");
      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        List<Post> list = [];
        for (var element in data["data"]) {
          list.add(Post.fromMap(element));
        }
        return DataState.success(data: list);
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<User>> getMe() async {
    try {
      http.Response res = await client.get("getMe");
      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.success(data: User.fromMap(data["data"]));
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  Future<DataState<PitchModel>> createPitch({
    required String title,
    required String description,
    required File video,
  }) async {
    try {
      print(video);
      http.Response res = await client.multipartPost("uploadPitch", body: {
        "title": title,
        "description": description,
        "video": video,
      });

      print(res.body);

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.success(data: PitchModel.fromMap(data["data"]));
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<User>> updateProfilePic({required File newPic}) async {
    try {
      http.Response res = await client.multipartPost("uploadUserPic", body: {
        "image": newPic,
      });

      print(res.body);

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.success(data: User.fromMap(data["data"]));
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<User>> register({
    required String email,
    required String password,
    required String userType,
    required String fullName,
  }) async {
    try {
      http.Response res = await client.post("register", body: {
        "email": email,
        "password": password,
        "fullName": fullName,
        "userType": userType,
      });
      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.success(data: User.fromMap(data["data"]));
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<List<ChatModel>>> fetchMyChats() async {
    try {
      print("getMyChats");
      http.Response res = await client.get("getMyChats");
      if (res.statusCode == 200) {
        List<ChatModel> list = [];
        Map<String, dynamic> data = jsonDecode(res.body);

        for (var element in data["data"]) {
          list.add(ChatModel.fromMap(element));
        }
        return DataState.success(data: list);
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data.toString(),
          title: "Error",
        );
      }
    } catch (e, s) {
      print(e);
      print(s);
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<List<ChatMessage>>> fetchMessages(
    int counterpartUserId,
  ) async {
    try {
      http.Response res =
          await client.get("getMessages?cUserId=$counterpartUserId");
      if (res.statusCode == 200) {
        List<ChatMessage> list = [];
        Map<String, dynamic> data = jsonDecode(res.body);

        for (var element in data["data"]) {
          list.add(ChatMessage.fromMap(element));
        }
        return DataState.success(data: list);
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data.toString(),
          title: "Error",
        );
      }
    } catch (e, s) {
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<DataState<List<ChatMessage>>> sendMessage({
    required int cUserId,
    required String text,
    File? attachment,
  }) async {
    try {
      Map<String, dynamic> postData = {
        "cUserId": cUserId.toString(),
        "message": text,
      };
      if (attachment != null) {
        postData["attachment"] = attachment;
      }
      http.Response res = await client.multipartPost(
        "sendMessage",
        body: postData,
      );

      if (res.statusCode == 200) {
        List<ChatMessage> list = [];
        Map<String, dynamic> data = jsonDecode(res.body);
        for (var element in data["data"]) {
          list.add(ChatMessage.fromMap(element));
        }
        return DataState.success(data: list);
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return DataState.error(
          message: data["message"],
          title: "Error",
        );
      }
    } catch (e, s) {
      if (e is SocketException) {
        return DataState.error(
          message: "No connection to the server",
          title: "Connection error",
        );
      }
      print(e.toString());
      return DataState.error(
        message: s.toString(),
        title: e.toString(),
      );
    }
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      http.Response res = await client.get("getNotifications");
      if (res.statusCode == 200) {
        List<NotificationModel> list = [];
        print("Notifications: " + res.body);
        Map<String, dynamic> data = jsonDecode(res.body);

        for (var element in data["data"]) {
          list.add(NotificationModel.fromMap(element));
        }
        return list;
      } else {
        Map<String, dynamic> data = jsonDecode(res.body);
        return [];
      }
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }

  @override
  Future<DataState<bool>> removePitch(int id) async {
    try {
      http.Response res = await client.get("removePitch?id=$id");
      if (res.statusCode == 200) {
        return DataState.success(data: true);
      } else {
        return DataState.error(title: "Error", message: "Invalid pitch id");
      }
    } catch (e, s) {
      print(e);
      print(s);
      return DataState.error(title: e.toString(), message: s.toString());
    }
  }
}
