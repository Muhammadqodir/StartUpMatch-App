import 'package:startupmatch/data/data_source.dart';
import 'package:startupmatch/data/data_state.dart';
import 'package:startupmatch/models/chat/chat_message.dart';
import 'package:startupmatch/models/chat/chat_model.dart';
import 'package:startupmatch/models/post/announcement.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/post/post.dart';

import '../../models/user.dart';

class TestData {
  static User testUser = User(
    id: 0,
    name: "Muhammadqodir Abduvoiotv",
    username: "@mqodir",
    email: "m.qodir777@gmail.com",
    usertype: "startuper",
    pic: "https://abduvoitov.uz/images/abduvoitov.JPG",
    joined: "2012-02-27 13:27:00",
    location: "Stavropol",
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
    videoUrl:
        "https://videos.pexels.com/video-files/3209663/3209663-uhd_2560_1440_25fps.mp4",
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
}
