// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:startupmatch/models/post/comment.dart';
import 'package:startupmatch/models/post/like.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';

class PitchModel extends Post {
  String title;
  String description;
  String videoUrl;

  PitchModel({
    required super.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required super.owner,
    required super.likes,
    required super.comments,
    required super.date,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'id': id,
      'owner': owner.toMap(),
      'likes': likes.map((x) => x.toMap()).toList(),
      'comments': comments.map((x) => x.toMap()).toList(),
      'date': date,
    };
  }

  @override
  factory PitchModel.fromMap(Map<String, dynamic> map) {
    return PitchModel(
      title: map['title'] as String,
      description: map['description'] as String,
      videoUrl: map['videoUrl'] as String,
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

  @override
  String toJson() => json.encode(toMap());

  @override
  factory PitchModel.fromJson(String source) =>
      PitchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}