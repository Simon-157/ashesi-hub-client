import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/components/card_custom.dart';
import 'package:hub_client/components/custome_image.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/ui/widgets/feed/post/post_buttons.dart';
import 'package:hub_client/ui/widgets/feed/post/post_view.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserPost extends StatelessWidget {
  final PostModel post;

  UserPost({Key? key, required this.post}) : super(key: key);

  final DateTime timestamp = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 550,
            child: CustomCard(
              onTap: () {},
              borderRadius: BorderRadius.circular(10.0),
              child: OpenContainer(
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (BuildContext context, VoidCallback _) {
                  return ViewImage(post: post);
                },
                closedElevation: 0.0,
                closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                onClosed: (v) {},
                closedColor: const Color.fromARGB(220, 13, 35, 57),
                closedBuilder:
                    (BuildContext context, VoidCallback openContainer) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            child: CustomImage(
                              imageUrl: post.mediaUrl,
                              height: 150.0,
                              fit: BoxFit.cover,
                              width: 300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3.0, vertical: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Row(
                                    children: [
                                      buildLikeButton(post),
                                      const SizedBox(width: 5.0),
                                      InkWell(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            CupertinoPageRoute(builder:
                                                    (BuildContext context) {
                                              return Container();
                                            }
                                                // builder: (_) => Comments(post: post),
                                                ),
                                          );
                                        },
                                        child: const Icon(
                                          CupertinoIcons.chat_bubble,
                                          size: 25.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: StreamBuilder(
                                          stream: likesRef
                                              .where('postId',
                                                  isEqualTo: post.postId)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              QuerySnapshot? snap =
                                                  snapshot.data;
                                              List<DocumentSnapshot> docs =
                                                  snap!.docs;
                                              return buildLikesCount(
                                                  context, docs.length);
                                            } else {
                                              return buildLikesCount(
                                                  context, 0);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    StreamBuilder(
                                      stream: commentRef
                                          .doc(post.postId)
                                          .collection("comments")
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          QuerySnapshot? snap = snapshot.data;
                                          List<DocumentSnapshot> docs =
                                              snap!.docs;
                                          return buildCommentsCount(
                                              context, docs.length);
                                        } else {
                                          return buildCommentsCount(context, 0);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: post.description != null &&
                                      post.description.toString().isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 3.0),
                                    child: Text(
                                      post.description,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .color,
                                        fontSize: 15.0,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3.0),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    timeago.format(post.timestamp.toDate()),
                                    style: const TextStyle(fontSize: 10.0),
                                  ),
                                ),
                                // SizedBox(height: 5.0),
                              ],
                            ),
                          )
                        ],
                      ),
                      buildUser(context, post),
                    ],
                  );
                },
              ),
            )));
  }
}
