
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String postId;
  String ownerId;
  String username;
  String description;
  String mediaUrl;
  Timestamp timestamp;
  

  PostModel({
    this.id,
    this.postId,
    this.ownerId,
    this.description,
    this.mediaUrl,
    this.username,
    this.timestamp,
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