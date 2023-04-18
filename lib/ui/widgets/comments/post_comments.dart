import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/comments_model.dart';
import 'package:hub_client/services/comments_service.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostComments extends StatefulWidget {
  final String postId;
  final String ownerId;

  const PostComments({Key? key, required this.postId, required this.ownerId})
      : super(key: key);

  @override
  _PostCommentsState createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  late TextEditingController _commentController;
  late FocusNode _commentFocusNode;

  CommentsService commentService = CommentsService();

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _commentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _commentController,
                  focusNode: _commentFocusNode,
                  decoration: const InputDecoration(
                    hintText: "Add a comment",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(218, 48, 89, 105),
                ),
                onPressed: () {
                  String commentText = _commentController.text.trim();
                  if (commentText.isNotEmpty) {
                    print(commentText);
                    commentService.uploadComment(
                        context, commentText, widget.postId, widget.ownerId);

                    _commentController.clear();
                    _commentFocusNode.unfocus();
                  } else {
                    print("comment cant be empty");
                  }
                },
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        StreamBuilder(
            stream: commentRef
                .doc(widget.postId)
                .collection("comments")
                .orderBy("timestamp", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                QuerySnapshot<Map<String, dynamic>>? snap =
                    snapshot.data as QuerySnapshot<Map<String, dynamic>>?;
                List<CommentModel> comments = snap!.docs
                    .map((doc) => CommentModel.fromJson(doc.data()))
                    .toList();
                return Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      CommentModel comment = comments[index];
                      return SizedBox(
                          height: 100,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(comment.userDp ?? ""),
                            ),
                            title: Text(comment.username ?? ""),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.comment ?? ""),
                                const SizedBox(height: 5),
                                Text(
                                  timeago.format(comment.timestamp!.toDate()),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.color,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return const Text(
                  "No comments",
                  style: TextStyle(color: Color.fromARGB(255, 198, 229, 232)),
                );
              }
            })
      ]),
    );
  }
}
