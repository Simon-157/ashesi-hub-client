/// The above class defines a PostModel with properties such as postId, ownerId, username, description,
/// mediaUrl, and timestamp, and includes methods for converting the data to and from JSON format.
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String postId;
  late String ownerId;
  late String username;
  late String description;
  late String mediaUrl;
  late Timestamp timestamp;

  PostModel({
    required this.postId,
    required this.ownerId,
    required this.description,
    required this.mediaUrl,
    required this.username,
    required this.timestamp,
  });

  PostModel.fromJson(Map<String, dynamic> json_data) {
    postId = json_data['postId'];
    ownerId = json_data['ownerId'];
    username = json_data['username'];
    description = json_data['description'];
    mediaUrl = json_data['mediaUrl'];
    timestamp = json_data['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['postId'] = postId;
    data['ownerId'] = ownerId;
    data['description'] = description;
    data['mediaUrl'] = mediaUrl;
    data['timestamp'] = timestamp;
    data['username'] = username;
    return data;
  }
  
}
