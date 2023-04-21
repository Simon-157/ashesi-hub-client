import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

CollectionReference likesRef = FirebaseFirestore.instance.collection('likes');

class LikesService{

static Stream<QuerySnapshot<Map<String, dynamic>>> getLikesStream(String postId) {
  return likesRef.where('postId', isEqualTo: postId).snapshots()
      as Stream<QuerySnapshot<Map<String, dynamic>>>;
}

}
