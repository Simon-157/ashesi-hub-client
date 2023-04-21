import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/base_service.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:provider/provider.dart';

class CommentsService extends Service {
  /// The function uploads a comment to a post and sends a notification to the post owner if the comment
  /// is made by someone other than the owner.
  uploadComment(BuildContext context, String comment, String postId,
      String ownerId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    String? currentUserId = userState.uid;
    DocumentSnapshot doc = await usersRef.doc(currentUserId).get();

    var user = UserModel.fromJson(doc.data() as Map<String, dynamic>);

    await commentRef.doc(postId).collection("comments").add({
      "username": user.username,
      "comment": comment,
      "timestamp": Timestamp.now(),
      "userDp": user.avatar_url,
      "userId": user.user_id,
    });
    bool isNotMe = ownerId != currentUserId;
    if (isNotMe) {
      addCommentToNotification("comment", comment, user.username, user.user_id,
          postId, "", ownerId, user.avatar_url);
    }
  }

  /// The function adds a comment notification to a Firestore collection.
  addCommentToNotification(
      String type,
      String commentData,
      String username,
      String userId,
      String postId,
      String mediaUrl,
      String ownerId,
      String userDp) async {
    await notificationRef.doc(ownerId).collection('notifications').add({
      "type": type,
      "commentData": commentData,
      "username": username,
      "userId": userId,
      "userDp": userDp,
      "postId": postId,
      "mediaUrl": mediaUrl,
      "timestamp": Timestamp.now(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCommentsStream(String postId) {
    return commentRef.doc(postId).collection("comments").snapshots();
  }
}
