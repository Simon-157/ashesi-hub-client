import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hub_client/utils/firebase_collections.dart';


String currentUserId() {
  return firebaseAuth.currentUser!.uid;
}

Future<bool> isUserFollowing(String profileId) async {
  DocumentSnapshot doc = await followersRef
      .doc(profileId)
      .collection('userFollowers')
      .doc(currentUserId())
      .get();
  return doc.exists;
}

Stream<DocumentSnapshot> getUserSnapshot(String profileId) {
  return usersRef.doc(profileId).snapshots();
}

Stream<QuerySnapshot> getUserPostsSnapshot(String profileId) {
  return postRef
      .where('ownerId', isEqualTo: profileId)
      .snapshots();
}

Stream<QuerySnapshot> getUserFollowersSnapshot(String profileId) {
  return followersRef
      .doc(profileId)
      .collection('userFollowers')
      .snapshots();
}

Stream<QuerySnapshot> getUserFollowingSnapshot(String profileId) {
  return followingRef
      .doc(profileId)
      .collection('userFollowing')
      .snapshots();
}

// Get user document by profile ID
Future<DocumentSnapshot> getUserDocument(String profileId) async {
  return await usersRef.doc(profileId).get();
}




