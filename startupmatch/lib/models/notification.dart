import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  int id;
  String title;
  String content;
  String icon;
  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.icon,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'icon': icon,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
