import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/firestore_services/profile_services.dart';
import 'package:hub_client/utils/firebase_collections.dart';

class FollowService {
  /// The function handles the deletion of unfollowed user's data from the followers, following, and
  /// notification collections.
  ///
  /// Args:
  ///   profileId (String): The ID of the user profile that is being unfollowed.
  static handleUnfollowDeletion(String? profileId) async {
    followersRef
        .doc(profileId)
        .collection('userFollowers')
        .doc(ProfileService.currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    followingRef
        .doc(ProfileService.currentUserId())
        .collection('userFollowing')
        .doc(profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    notificationRef
        .doc(profileId)
        .collection('notifications')
        .doc(ProfileService.currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  /// This function updates the followers and following collections of users and also updates the
  /// notification feeds when a user follows another user.
  ///
  /// Args:
  ///   profileId (String): The ID of the user who is being followed.
  ///   student (UserModel): The `student` parameter is an instance of the `UserModel` class, which
  /// contains information about a user, such as their username, user ID, and avatar URL.
  static handleFollowUpdate(String? profileId, UserModel student) async {
    followersRef
        .doc(profileId)
        .collection('userFollowers')
        .doc(ProfileService.currentUserId())
        .set({});
    followingRef
        .doc(ProfileService.currentUserId())
        .collection('userFollowing')
        .doc(profileId)
        .set({});
    notificationRef
        .doc(profileId)
        .collection('notifications')
        .doc(ProfileService.currentUserId())
        .set({
      "type": "follow",
      "ownerId": profileId,
      "username": student.username,
      "userId": student.userId,
      "userDp": student.avatarUrl,
      "timestamp": DateTime.now(),
    });
  }
}
