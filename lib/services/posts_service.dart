import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/base_service.dart';
import 'package:hub_client/utils/authentication.dart';
import 'package:hub_client/utils/firebase_collections.dart';
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

  Future<void> uploadPost(String image, String description) async {
    // Upload the image to Firebase Storage and get the download URL
    // String mediaUrl = await uploadImage(posts, image);

    // Get the current user's data
    DocumentSnapshot userDoc = await usersRef.doc(uid).get();
    UserModel user = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

    await postRef
        .doc()
        .set({
          'id': postRef.id,
          'postId': postRef.id,
          'username': user.email,
          'ownerId': uid,
          'mediaUrl': image,
          'description': description ?? 'No caption',
          'timestamp': FieldValue.serverTimestamp(),
        })
        .then((value) => print("post added"))
        .onError((error, stackTrace) => print(error));
  }

//upload a comment
  // uploadComment(String currentUserId, String comment, String postId,
  //     String ownerId, String mediaUrl) async {
  //   DocumentSnapshot doc = await usersRef.doc(currentUserId).get();
  //   var user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
  //   await commentRef.doc(postId).collection("comments").add({
  //     "username": user.username,
  //     "comment": comment,
  //     "timestamp": Timestamp.now(),
  //     "userDp": user.photoUrl,
  //     "userId": user.id,
  //   });
  //   bool isNotMe = ownerId != currentUserId;
  //   if (isNotMe) {
  //     addCommentToNotification("comment", comment, user.username, user.id,
  //         postId, mediaUrl, ownerId, user.photoUrl);
  //   }
  // }

//add the comment to notification collection
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

//add the likes to the notfication collection
  addLikesToNotification(String type, String username, String userId,
      String postId, String mediaUrl, String ownerId, String userDp) async {
    await notificationRef
        .doc(ownerId)
        .collection('notifications')
        .doc(postId)
        .set({
      "type": type,
      "username": username,
      "userId": firebaseAuth.currentUser.uid,
      "userDp": userDp,
      "postId": postId,
      "mediaUrl": mediaUrl,
      "timestamp": Timestamp.now(),
    });
  }

  //remove likes from notification
  removeLikeFromNotification(
      String ownerId, String postId, String currentUser) async {
    bool isNotMe = currentUser != ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUser).get();
      var user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notificationRef
          .doc(ownerId)
          .collection('notifications')
          .doc(postId)
          .get()
          .then((doc) => {
                if (doc.exists) {doc.reference.delete()}
              });
    }
  }
}
