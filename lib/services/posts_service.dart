import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/base_service.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:provider/provider.dart';


class PostService extends Service {
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


  
}
