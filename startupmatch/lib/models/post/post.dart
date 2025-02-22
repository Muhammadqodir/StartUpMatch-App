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
  List<Like> dislikes;
  List<Comment> comments;
  String date;
  int views;

  Post({
    required this.id,
    required this.owner,
    required this.likes,
    required this.dislikes,
    required this.comments,
    required this.date,
    required this.views,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner': owner.toMap(),
      'likes': likes.map((x) => x.toMap()).toList(),
      'dislikes': dislikes.map((x) => x.toMap()).toList(),
      'comments': comments.map((x) => x.toMap()).toList(),
      'date': date,
      'views': views,
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
        (map['likes'] as List<dynamic>).map<Like>(
          (x) => Like.fromMap(x as Map<String, dynamic>),
        ),
      ),
      dislikes: List<Like>.from(
        (map['dislikes'] as List<dynamic>).map<Like>(
          (x) => Like.fromMap(x as Map<String, dynamic>),
        ),
      ),
      comments: List<Comment>.from(
        (map['comments'] as List<dynamic>).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: map['date'] as String,
      views: map['views'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
