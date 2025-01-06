// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:startupmatch/data/remote/remote_data_source.dart';

class User {
  int id;
  String fullName;
  String email;
  String userType;
  String pic;
  String joined;
  String location;
  String about;
  String token;
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.userType,
    required this.pic,
    required this.joined,
    required this.location,
    required this.about,
    required this.token,
  });

  bool equal(User user) {
    if (user.id == id) {
      return true;
    } else {
      return false;
    }
  }

  String getUserPicUrl() {
    if (pic.contains("http")) {
      return pic;
    }
    return serverBaseUrl + pic;
  }

  String getJoinedDate() {
    DateTime parsedDate = DateTime.parse(joined);
    return DateFormat.yMMMM().format(parsedDate);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'userType': userType,
      'pic': pic,
      'joined': joined,
      'location': location,
      'about': about,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      userType: map['userType'] as String,
      pic: map['pic'] as String,
      joined: map['joined'] as String,
      location: map['location'] as String,
      about: map['about'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
