// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/utils/extentions.dart';

class ChatMessage {
  int id;
  String content;
  String media;
  User from;
  User to;
  String time;
  String? readTime;
  ChatMessage({
    required this.id,
    required this.content,
    required this.media,
    required this.from,
    required this.to,
    required this.time,
    this.readTime,
  });

  bool isMy() {
    return Random().nextBool();
  }

  DateTime getDateTime() {
    DateTime dateTime = DateTime.parse(time);
    return dateTime;
  }

  bool isRead() {
    return readTime != null;
  }

  String getShortTime() {
    DateTime dateTime = getDateTime();
    if (dateTime.isToday) {
      return DateFormat.Hm().format(dateTime);
    }
    return DateFormat.MEd().format(dateTime);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'media': media,
      'from': from.toMap(),
      'to': to.toMap(),
      'time': time,
      'readTime': readTime,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as int,
      content: map['content'] as String,
      media: map['media'] as String,
      from: User.fromMap(map['from'] as Map<String,dynamic>),
      to: User.fromMap(map['to'] as Map<String,dynamic>),
      time: map['time'] as String,
      readTime: map['readTime'] != null ? map['readTime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) => ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
