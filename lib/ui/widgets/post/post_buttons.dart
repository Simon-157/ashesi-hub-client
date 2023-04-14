import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/services/app_notification_service.dart';
import 'package:hub_client/services/posts_service.dart';
import 'package:hub_client/utils/authentication.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:hub_client/widgets/loaders.dart';
import 'package:like_button/like_button.dart';

final PostService services = PostService();

currentUserId() {
  return uid;
}

buildImage(BuildContext context, PostModel post) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: CachedNetworkImage(
        imageUrl: post.mediaUrl,
        placeholder: (context, url) {
          return circularProgress(context);
        },
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
        height: 400.0,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
    ),
  );
}

buildLikeButton(PostModel post) {
  return StreamBuilder(
    stream: likesRef.where('postId', isEqualTo: post.postId).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
        List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];
        QueryDocumentSnapshot? currentLike;

        // Check if current user has already liked the post
        for (QueryDocumentSnapshot doc in docs) {
          if (doc['userId'] == currentUserId()) {
            currentLike = doc;
            break;
          }
        }

// TODO: REMOVE ALL DOCUMENT AND DELETION FOR LIKE TO A SERVICE FILE
        Future<bool> onLikeButtonTapped(bool isLiked) async {
          if (currentLike == null) {
            likesRef.add({
              'userId': currentUserId(),
              'postId': post.postId,
              'dateCreated': Timestamp.now(),
            });
            addLikesToNotification(post, currentUserId());
            return true;
          } else {
            likesRef.doc(currentLike.id).delete();
            removeLikeFromNotification(
                post.ownerId, post.postId, currentUserId());
            return false;
          }
        }

        return LikeButton(
          isLiked: currentLike != null,
          onTap: onLikeButtonTapped,
          size: 25.0,
          circleColor: const CircleColor(
              start: Color(0xffFFC0CB), end: Color(0xffff0000)),
          bubblesColor: const BubblesColor(
              dotPrimaryColor: Color(0xffFFA500),
              dotSecondaryColor: Color(0xffd8392b),
              dotThirdColor: Color(0xffFF69B4),
              dotLastColor: Color(0xffff8c00)),
          likeBuilder: (bool isLiked) {
            return Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked
                  ? Colors.red
                  : (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
              size: 25,
            );
          },
        );
      }
      return Container();
    },
  );
}


