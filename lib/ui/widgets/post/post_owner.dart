import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:provider/provider.dart';

buildUser(BuildContext context, PostModel post) {
  final userState = Provider.of<UserState>(context, listen: false);
  String? currentUserId = userState.uid;
  bool isMe = currentUserId != null && currentUserId == post.ownerId;

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
