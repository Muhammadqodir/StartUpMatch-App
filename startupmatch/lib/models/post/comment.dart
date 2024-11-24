// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comment {
  int id;
  int author;
  String comment;
  String date;
  Comment({
    required this.id,
    required this.author,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'comment': comment,
      'date': date,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as int,
      author: map['author'] as int,
      comment: map['comment'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
