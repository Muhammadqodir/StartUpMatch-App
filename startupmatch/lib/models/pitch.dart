// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:startupmatch/models/comment.dart';
import 'package:startupmatch/models/like.dart';
import 'package:startupmatch/models/user.dart';

class PitchModel {
  int id;
  String title;
  String description;
  String videoUrl;
  User owner;
  List<Like> likes;
  List<Comment> comments;
  String date;
  PitchModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.owner,
    required this.likes,
    required this.comments,
    required this.date,
  });
}
