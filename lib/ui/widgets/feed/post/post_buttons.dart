import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/posts_service.dart';
import 'package:hub_client/ui/widgets/feed/post/post_view.dart';
import 'package:hub_client/utils/authentication.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:like_button/like_button.dart';


final PostService services = PostService();


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

          Future<bool> onLikeButtonTapped(bool isLiked) async {
            if (currentLike == null) {
              likesRef.add({
                'userId': currentUserId(),
                'postId': post.postId,
                'dateCreated': Timestamp.now(),
              });
              addLikesToNotification(post);
              return true;
            } else {
              likesRef.doc(currentLike.id).delete();
              services.removeLikeFromNotification(
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

  addLikesToNotification(PostModel post) async {
    bool isNotMe = currentUserId() != post.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      var user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      services.addLikesToNotification(
        "like",
        user.username,
        currentUserId(),
        post.postId,
        post.mediaUrl,
        post.ownerId,
        user.avatar_url,
      );
    }
  }

  buildLikesCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Text(
        '$count likes',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      ),
    );
  }

  buildCommentsCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: Text(
        '-   $count comments',
        style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  buildUser(BuildContext context, PostModel post) {
    bool isMe = uid != null && uid == post.ownerId;
    // if (uid == null) {
    //   return Container();
    // }

    return StreamBuilder(
      stream: usersRef.doc(post.ownerId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot<Object?>? snap = snapshot.data;
          UserModel user = UserModel.fromJson(snap!.data());
          return Visibility(
            // visible: !isMe,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: GestureDetector(
                  onTap: () => showProfile(context, profileId: post.ownerId),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        user.avatar_url.isEmpty
                            ? CircleAvatar(
                                radius: 20.0,
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                child: Center(
                                  child: Text(
                                    user.username.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 20.0,
                                backgroundImage: CachedNetworkImageProvider(
                                  user.avatar_url,
                                ),
                              ),
                        const SizedBox(width: 5.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ${isMe ? "You" : post.username}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Text(
                              'Ashesi',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Color(0xff4D4D4D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }


  showProfile(BuildContext context, {required String profileId}) {
    context.go('/profile/$profileId');
  }