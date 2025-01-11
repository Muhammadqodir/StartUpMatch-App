import 'dart:io';

import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/chat/chat_message.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/models/post/announcement.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/post/post.dart';

import '../../models/user.dart';

class TestData {
  static User unautorizedUser = User(
    id: -1,
    fullName: "Undefined",
    email: "Undefined",
    userType: "Undefined",
    pic: "Undefined",
    joined: "Undefined",
    location: "Undefined",
    token: "Undefined",
    about: "",
  );

  static User testUser = User(
    id: 0,
    fullName: "Muhammadqodir Abduvoiotv",
    email: "m.qodir777@gmail.com",
    userType: "startuper",
    pic: "uploads/6HFfFMEnKYxbyrVx_user.jpg",
    joined: "2012-02-27 13:27:00",
    location: "Stavropol",
    token: "Undefined",
    about: "",
  );

  static ChatMessage testMessage = ChatMessage(
    id: 0,
    content: "test",
    media: [],
    from: testUser,
    to: testUser,
    time: "2012-02-27 13:27:00",
  );

  static ChatModel testChatModel = ChatModel(
    id: 0,
    user: testUser,
    user1: testUser,
    lastMessages: [
      testMessage,
      testMessage,
      testMessage,
    ],
  );

  static AnnouncementModel announcement = AnnouncementModel(
    id: 0,
    title: "Pitch title",
    image:
        "https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp",
    btnTitle: "More",
    content:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    link: "https://alfocus.uz/",
    owner: testUser,
    likes: [],
    comments: [],
    date: "2012-02-27 13:27:00",
  );

  static PitchModel pitchModel = PitchModel(
    id: 0,
    title: "Pitch title",
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    videoUrl: "uploads/WrzxCKGTAc_pitch.mp4",
    owner: testUser,
    likes: [],
    comments: [],
    date: "2012-02-27 13:27:00",
  );

  static PitchModel pitchModel1 = PitchModel(
    id: 1,
    title: "Pitch title",
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    videoUrl:
        "https://videos.pexels.com/video-files/4778723/4778723-uhd_1440_2732_25fps.mp4",
    owner: testUser,
    likes: [],
    comments: [],
    date: "2012-02-27 13:27:00",
  );

  static PitchModel pitchModel2 = PitchModel(
    id: 2,
    title: "Pitch title",
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    videoUrl:
        "https://videos.pexels.com/video-files/5741026/5741026-uhd_1440_2560_30fps.mp4",
    owner: testUser,
    likes: [],
    comments: [],
    date: "2012-02-27 13:27:00",
  );

  static List<Post> pitches = [
    TestData.pitchModel,
    TestData.pitchModel1,
    TestData.announcement,
    TestData.pitchModel2,
  ];
}

class TestDataSource implements DataSource {
  @override
  Future<DataState<List<Post>>> fetchFeed() async {
    return DataState.success(data: TestData.pitches);
  }

  @override
  Future<DataState<List<Post>>> fetchMyPosts() async {
    return DataState.success(data: TestData.pitches);
  }

  @override
  Future<DataState<User>> login({
    required String email,
    required String password,
  }) async {
    return DataState.success(data: TestData.testUser);
  }

  @override
  Future<DataState<User>> updateProfilePic({
    required File newPic,
  }) async {
    return DataState.error(
      title: "This is test datasource",
      message: "This is test datasource",
    );
  }

  @override
  Future<DataState<User>> updateProfileData({
    required Map<String, dynamic> data,
  }) async {
    return DataState.error(
      title: "This is test datasource",
      message: "This is test datasource",
    );
  }

  @override
  Future<DataState<User>> register({
    required String email,
    required String password,
    required String fullName,
    required String userType,
  }) async {
    return DataState.success(data: TestData.testUser);
  }

  @override
  Future<DataState<User>> getMe() async {
    return DataState.error(
      title: "This is test datasource",
      message: "This is test datasource",
    );
  }

  @override
  Future<DataState<List<Post>>> getMyPosts() async {
    return DataState.error(
      title: "This is test datasource",
      message: "This is test datasource",
    );
  }
}
