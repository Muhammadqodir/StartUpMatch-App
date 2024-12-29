// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:startupmatch/models/post/comment.dart';
import 'package:startupmatch/models/post/like.dart';
import 'package:startupmatch/models/post/post.dart';
import 'package:startupmatch/models/user.dart';

class AnnouncementModel extends Post {
  String content;
  String image;
  String title;
  String link;
  String btnTitle;

  AnnouncementModel({
    required super.id,
    required super.owner,
    required super.likes,
    required super.comments,
    required super.date,
    required this.content,
    required this.image,
    required this.link,
    required this.title,
    required this.btnTitle,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'image': image,
      'title': title,
      'link': link,
      'id': id,
      'btnTitle': btnTitle,
      'owner': owner.toMap(),
      'likes': likes.map((x) => x.toMap()).toList(),
      'comments': comments.map((x) => x.toMap()).toList(),
      'date': date,
    };
  }

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      content: map['content'] as String,
      image: map['image'] as String,
      title: map['title'] as String,
      btnTitle: map['btnTitle'] as String,
      link: map['link'] as String,
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

  factory AnnouncementModel.fromJson(String source) =>
      AnnouncementModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
