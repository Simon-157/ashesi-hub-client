/// The CommentModel class is a Dart class that represents a comment with properties such as username,
/// comment text, timestamp, user profile picture, and user ID, and includes methods for converting to
/// and from JSON format.
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? username;
  String? comment;
  Timestamp? timestamp;
  String? userDp;
  String? userId;

  CommentModel({
    this.username,
    this.comment,
    this.timestamp,
    this.userDp,
    this.userId,
  });

  CommentModel.fromJson(Map<String, dynamic> json_data) {
    username = json_data['username'];
    comment = json_data['comment'];
    timestamp = json_data['timestamp'];
    userDp = json_data['userDp'];
    userId = json_data['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['comment'] = comment;
    data['timestamp'] = timestamp;
    data['userDp'] = userDp;
    data['userId'] = userId;
    return data;
  }
}
