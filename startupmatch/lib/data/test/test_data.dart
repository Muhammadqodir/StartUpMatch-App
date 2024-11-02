import 'package:startupmatch/models/pitch.dart';

import '../../models/user.dart';

class TestData {
  static User testUser = User(
    id: 0,
    name: "Muhammadqodir Abduvoiotv",
    username: "@mqodir",
    email: "m.qodir777@gmail.com",
    usertype: "startuper",
    pic: "https://abduvoitov.uz/images/abduvoitov.JPG",
    joined: "2024.01.01 15:23",
    location: "Stavropol",
  );

  static PitchModel pitchModel = PitchModel(
    id: 0,
    title: "Pitch title",
    description:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    videoUrl: "assets/demo1.jpeg",
    owner: testUser,
    likes: [],
    comments: [],
    date: "2024.01.01 13:24",
  );
}
