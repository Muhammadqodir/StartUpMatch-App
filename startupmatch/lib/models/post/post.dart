// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:startupmatch/models/post/comment.dart';
import 'package:startupmatch/models/post/like.dart';
import 'package:startupmatch/models/post/pitch.dart';
import 'package:startupmatch/models/user.dart';

class Post {
  int id;
  User owner;
  List<Like> likes;
  List<Comment> comments;
  String date;

  Post({
    required this.id,
    required this.owner,
    required this.likes,
    required this.comments,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner': owner.toMap(),
      'likes': likes.map((x) => x.toMap()).toList(),
      'comments': comments.map((x) => x.toMap()).toList(),
      'date': date,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("videoUrl")) {
      return PitchModel.fromMap(map);
    }
    return Post(
      id: map['id'] as int,
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
      likes: List<Like>.from(
        (map['likes'] as List<int>).map<Like>(
          (x) => Like.fromMap(x as Map<String, dynamic>),
        ),
      ),
      comments: List<Comment>.from(
        (map['comments'] as List<int>).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
