import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:startupmatch/models/user.dart';
import 'package:startupmatch/utils/extentions.dart';

class ChatMessage {
  int id;
  String content;
  List<String> media;
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
}
