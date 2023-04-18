import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/base_service.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PostService extends Service {
  String postId = Uuid().v4();

//uploads profile picture to the users collection
  uploadProfilePicture(File image, User user) async {
    String link = await uploadImage(profilePic, image);
    var ref = usersRef.doc(user.uid);
    ref.update({
      "photoUrl": link,
    });
  }

  /// The function uploads a post to a Firestore database with information such as the user's email,
  /// image, and description.
  Future<void> uploadPost(
      BuildContext context, String image, String description) async {
    final userState = Provider.of<UserState>(context, listen: false);
    String? currentUserId = userState.uid;

    DocumentSnapshot userDoc = await usersRef.doc(currentUserId).get();
    UserModel user = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

    DocumentReference newPostRef =
        postRef.doc(); // create a new document reference
    String newPostId =
        newPostRef.id; // get the ID of the new document reference

    await newPostRef.set({
      'username': user.email,
      'ownerId': currentUserId,
      'mediaUrl': image,
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
      'email_sent': false
    }).then((value) {
      // update the document with the ID and postId fields
      newPostRef.update({
        'id': newPostId,
        'postId': newPostId,
      });
      // var em = ApiService.sendEmail(newPostId);
      // print(em);
      print("post added");
    }).onError((error, stackTrace) => null);
  }

  /// The function uploads a comment to a post and sends a notification to the post owner if the comment
  /// is made by someone other than the owner.
  uploadComment(String currentUserId, String comment, String postId,
      String ownerId, String mediaUrl) async {
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
          postId, mediaUrl, ownerId, user.avatar_url);
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

}
