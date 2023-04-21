import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? type;
  String? username;
  String? userId;
  String? userDp;
  String? postId;
  String? mediaUrl;
  String? commentData;
  Timestamp? timestamp;
  NotificationModel(this.type, this.username, this.userId, this.userDp, this.postId,
      this.commentData, this.mediaUrl, this.timestamp);

  NotificationModel.fromJson(Map<String, dynamic> json_data) {
    type = json_data['type'];
    username = json_data['username'];
    userId = json_data['userId']; 
    userDp = json_data['userDp'];
    postId = json_data['postId'];
    mediaUrl = json_data['mediaUrl'];
    commentData = json_data['commentData'];
    timestamp = json_data['timestamp'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['username'] = username;
    data['userId'] = userId;
    data['userDp'] = userDp;
    data['postId'] = postId;
    data['mediaUrl'] = mediaUrl;
    data['commentData'] = commentData;
    data['timestamp'] = timestamp;
    return data;
  }
}