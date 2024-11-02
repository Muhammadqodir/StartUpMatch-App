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
}
