// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int id;
  String name;
  String username;
  String email;
  String usertype;
  String pic;
  String joined;
  String location;
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.usertype,
    required this.pic,
    required this.joined,
    required this.location,
  });

  bool equal(User user) {
    if (user.id == id) {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'usertype': usertype,
      'pic': pic,
      'joined': joined,
      'location': location,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      usertype: map['usertype'] as String,
      pic: map['pic'] as String,
      joined: map['joined'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
