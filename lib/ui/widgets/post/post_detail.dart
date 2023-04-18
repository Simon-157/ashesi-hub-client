import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/services/comments_service.dart';
import 'package:hub_client/services/likes_service.dart';
import 'package:hub_client/ui/widgets/comments/post_comments.dart';
import 'package:hub_client/ui/widgets/post/post_buttons.dart';
import 'package:hub_client/ui/widgets/post/post_interraction_counts.dart';
import 'package:hub_client/ui/widgets/post/post_owner.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailed extends StatefulWidget {
  final PostModel post;

  const PostDetailed({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailedState createState() => _PostDetailedState();
}

CommentsService commentService = CommentsService();
final DateTime timestamp = DateTime.now();

class _PostDetailedState extends State<PostDetailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerScrimColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF092A45),
        ),
        body: Center(
          child: Container(
            width: 600,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF05182D),
                  Color(0xFF092A45),
                  Color(0xFF0D2339)
                ],
              ),
            ),
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildUser(context, widget.post),
                  const SizedBox(height: 10),
                  buildImage(context, widget.post),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildLikeButton(widget.post),
                          const SizedBox(width: 2),
                          StreamBuilder(
                            stream: getLikesStream(widget.post.postId),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot<Map<String, dynamic>>? snap =
                                    snapshot.data;
                                List<DocumentSnapshot<Map<String, dynamic>>>
                                    docs = snap!.docs;
                                return buildLikesCount(context, docs.length);
                              } else {
                                return buildLikesCount(context, 0);
                              }
                            },
                          ),
                          const SizedBox(width: 20.0),
                          buildCommentButton(widget.post),
                          const SizedBox(
                            width: 2,
                          ),
                          StreamBuilder(
                            stream: commentService
                                .getCommentsStream(widget.post.postId),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot<Map<String, dynamic>>? snap =
                                    snapshot.data;
                                List<DocumentSnapshot<Map<String, dynamic>>>
                                    docs = snap!.docs;
                                return buildCommentsCount(context, docs.length);
                              } else {
                                return buildCommentsCount(context, 0);
                              }
                            },
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.timer_outlined, size: 13.0),
                                const SizedBox(width: 3.0),
                                Text(
                                  timeago
                                      .format(widget.post.timestamp.toDate()),
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 239, 233, 214)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // TODO
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 280,
                    child: PostComments(
                        postId: widget.post.postId,
                        ownerId: widget.post.ownerId),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
