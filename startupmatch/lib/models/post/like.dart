// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:startupmatch/models/user.dart';

class Like {
  int id;
  User author;
  String date;
  Like({
    required this.id,
    required this.author,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author.toMap(),
      'date': date,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      id: map['id'] as int,
      author: User.fromMap(map['author'] as Map<String,dynamic>),
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source) as Map<String, dynamic>);
}
