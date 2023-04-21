import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/services/profile_services.dart';
import 'package:hub_client/ui/views/post/post_view.dart';

class ProfilePostsGrid extends StatefulWidget {
  final String? profileId;

  const ProfilePostsGrid({required this.profileId});

  @override
  _ProfilePostsGridState createState() => _ProfilePostsGridState();
}

class _ProfilePostsGridState extends State<ProfilePostsGrid> {
  int _hoveredIndex = -1;

  void _onHover(int index) {
    setState(() {
      _hoveredIndex = index;
    });
  }

  void _onExit() {
    setState(() {
      _hoveredIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUserPostsSnapshot(widget.profileId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot> posts = snapshot.data!.docs;

          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 2.6 / 5,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = PostModel.fromJson(
                      posts[index].data() as Map<String, dynamic>);

                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to post details screen
                        PostView(post: post);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        transform: _hoveredIndex == index
                            ? (Matrix4.identity()..scale(1.05))
                            : Matrix4.identity(),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          image: post.mediaUrl == ""
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(post.mediaUrl),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: post.mediaUrl == ""
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        post.description,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      const Text(
                                        '🚀',
                                      )
                                    ]),
                              )
                            : null,
                      ),
                    ),
                    onHover: (event) {
                      _onHover(index);
                    },
                    onExit: (event) {
                      _onExit();
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
