
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String id;
  late String postId;
  late String ownerId;
  late String username;
  late String description;
  late String mediaUrl;
  late Timestamp timestamp;
  

  PostModel({
    required this.id,
    required this.postId,
    required this.ownerId,
    required this.description,
    required this.mediaUrl,
    required this.username,
    required this.timestamp,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    username= json['username'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postId'] = postId;
    data['ownerId'] = ownerId;
    data['description'] = description;
    data['mediaUrl'] = mediaUrl;
    data['timestamp'] = timestamp;
    data['username'] = username;
    return data;
  }
}