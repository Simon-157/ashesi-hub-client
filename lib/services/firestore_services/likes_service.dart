/// The LikesService class provides a method to retrieve a stream of likes for a specific post from a
/// Cloud Firestore collection.
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference likesRef = FirebaseFirestore.instance.collection('likes');

class LikesService{

static Stream<QuerySnapshot<Map<String, dynamic>>> getLikesStream(String postId) {
  return likesRef.where('postId', isEqualTo: postId).snapshots()
      as Stream<QuerySnapshot<Map<String, dynamic>>>;
}

}
