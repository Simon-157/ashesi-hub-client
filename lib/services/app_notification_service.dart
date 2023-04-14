import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hub_client/models/notification_model.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/utils/firebase_collections.dart';



Stream<List<NotificationModel>> getNotifications(String userId) {
  return FirebaseFirestore.instance
      .collection('notifications')
      .doc(userId)
      .collection('notifications')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return NotificationModel.fromJson(doc.data());
    }).toList();
  });
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

/// The function adds a notification to a Firestore collection with specific fields.

addLikesToNotification(PostModel post, String userId) async {
  bool isNotMe = userId != post.ownerId;

  if (isNotMe) {
    DocumentSnapshot doc = await usersRef.doc(userId).get();
    var user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    await notificationRef
        .doc(post.ownerId)
        .collection('notifications')
        .doc(post.postId)
        .set({
      "type": 'like',
      "userDp": user.avatar_url,
      "username": post.username,
      "userId": firebaseAuth.currentUser!.uid,
      "postId": post.postId,
      "mediaUrl": post.mediaUrl,
      "timestamp": Timestamp.now(),
    });
  }
}

/// The function removes a notification from a user's collection if the current user is not the owner of
/// the notification.
removeLikeFromNotification(
    String ownerId, String postId, String currentUserId) async {
  bool isNotMe = currentUserId != ownerId;

  if (isNotMe) {
    DocumentSnapshot doc = await usersRef.doc(currentUserId).get();
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
