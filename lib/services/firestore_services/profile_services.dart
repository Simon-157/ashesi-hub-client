import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hub_client/utils/firebase_collections.dart';

class ProfileService {
  static String currentUserId() {
    return firebaseAuth.currentUser!.uid;
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
}