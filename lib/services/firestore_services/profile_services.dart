import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hub_client/utils/firebase_collections.dart';

class ProfileService {
  static String currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  static Future<List<DocumentSnapshot>> getSuggestedUsers() async {
    String currentUser = currentUserId();
    List<DocumentSnapshot> users = [];

    // Get user document of the current user
    if (await doesDocumentExist(currentUser)) {
      DocumentSnapshot currentUserDocument = await getUserDocument(currentUser);

      // Get the user's interests
      String interestsA = currentUserDocument.get('major');
      String interestsB = currentUserDocument.get('residence');
      String interestsC = currentUserDocument.get('best_food');

      // Query users collection for users with similar interests
      QuerySnapshot querySnapshotA =
          await usersRef.where('major', isEqualTo: interestsA).limit(5).get();

      QuerySnapshot querySnapshotB = await usersRef
          .where('residence', isEqualTo: interestsB)
          .limit(5)
          .get();

      QuerySnapshot querySnapshotC = await usersRef
          .where('best_food', isEqualTo: interestsC)
          .limit(5)
          .get();

      // Add the results to the users list
      users.addAll(querySnapshotA.docs);
      users.addAll(querySnapshotB.docs);

      users.addAll(querySnapshotC.docs);

      return users;
    }
    return users;
  }

  static Stream<QuerySnapshot> getAllUsersSnapshot() {
    return usersRef.snapshots();
  }

  static Future<bool> isUserFollowing(String profileId) async {
    DocumentSnapshot doc = await followersRef
        .doc(profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
    return doc.exists;
  }

  static Stream<DocumentSnapshot> getUserSnapshot(String profileId) {
    return usersRef.doc(profileId).snapshots();
  }

  static Stream<QuerySnapshot> getUserPostsSnapshot(String profileId) {
    return postRef.where('ownerId', isEqualTo: profileId).snapshots();
  }

  static Stream<QuerySnapshot> getUserFollowersSnapshot(String profileId) {
    return followersRef.doc(profileId).collection('userFollowers').snapshots();
  }

  static Stream<QuerySnapshot> getUserFollowingSnapshot(String profileId) {
    return followingRef.doc(profileId).collection('userFollowing').snapshots();
  }

// Get user document by profile ID
  static Future<DocumentSnapshot> getUserDocument(String profileId) async {
    return await usersRef.doc(profileId).get();
  }

  static Future<bool> doesDocumentExist(String documentId) async {
    DocumentSnapshot snapshot = await usersRef.doc(documentId).get();
    return snapshot.exists;
  }
}
