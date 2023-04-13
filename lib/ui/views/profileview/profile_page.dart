import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/ui/views/profileview/profile_details.dart';
import 'package:hub_client/ui/widgets/profile/profile_edit_dialog.dart';
import 'package:hub_client/utils/firebase_collections.dart';

class Profile extends StatefulWidget {
  final String? profileId;

  const Profile({Key? key, required this.profileId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  late UserModel users;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF05182D), Color(0xFF092A45), Color(0xFF0D2339)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('ashHub'),
            backgroundColor: const Color(0xFF092A45),
            actions: [
              widget.profileId == firebaseAuth.currentUser?.uid
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: GestureDetector(
                          onTap: () {
                            firebaseAuth.signOut();
                            context.go('/login');
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: const Color(0xFF092A45),
                automaticallyImplyLeading: false,
                pinned: true,
                floating: false,
                toolbarHeight: 7.0,
                collapsedHeight: 8.0,
                expandedHeight: 225.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: StreamBuilder(
                    stream: usersRef.doc(widget.profileId).snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        UserModel user = UserModel.fromJson(
                          snapshot.data?.data() as Map<String, dynamic>,
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyStudentWidget(profileId: widget.profileId!),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              height: 50.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    StreamBuilder(
                                      stream: postRef
                                          .where('ownerId',
                                              isEqualTo: widget.profileId)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          QuerySnapshot<Object?>? snap =
                                              snapshot.data;
                                          List<DocumentSnapshot> docs =
                                              snap!.docs;
                                          return buildCount(
                                              "POSTS", docs.length);
                                        } else {
                                          return buildCount("POSTS", 0);
                                        }
                                      },
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 15.0),
                                      child: SizedBox(
                                        height: 50.0,
                                        width: 20,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: followersRef
                                          .doc(widget.profileId)
                                          .collection('userFollowers')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          QuerySnapshot<Object?>? snap =
                                              snapshot.data;
                                          List<DocumentSnapshot> docs =
                                              snap!.docs;
                                          return buildCount(
                                              "FOLLOWERS", docs.length);
                                        } else {
                                          return buildCount("FOLLOWERS", 0);
                                        }
                                      },
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 15.0),
                                      child: SizedBox(
                                        height: 50.0,
                                        width: 20,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: followingRef
                                          .doc(widget.profileId)
                                          .collection('userFollowing')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          QuerySnapshot<Object?>? snap =
                                              snapshot.data;
                                          List<DocumentSnapshot> docs =
                                              snap!.docs;
                                          return buildCount(
                                              "FOLLOWING", docs.length);
                                        } else {
                                          return buildCount("FOLLOWING", 0);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            buildProfileButton(user, context),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              // TODO SILVER DELEGATES TO SHOW USER POSTS
            ],
          ),
        ));
  }

  buildCount(String label, int count) {
    return Column(
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.green,
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        const SizedBox(height: 3.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontFamily: 'Ubuntu-Regular',
          ),
        )
      ],
    );
  }

  buildProfileButton(user, BuildContext context) {
    //if isMe then display "edit profile"
    bool isMe = widget.profileId == firebaseAuth.currentUser!.uid;
    if (isMe) {
      return buildButton(
          text: "Edit Profile",
          function: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => EditProfile(
                user: user,
              ),
            ));
          });
      //if you are already following the user then "unfollow"
    } else if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollow,
      );
      //if you are not following the user then "follow"
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollow,
      );
    }
  }

  buildButton({String? text, Function()? function}) {
    return Center(
        child: GestureDetector(
      onTap: function,
      child: Container(
        height: 40.0,
        width: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).colorScheme.secondary,
              const Color(0xff597FDB),
            ],
          ),
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    ));
  }

  handleUnfollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = false;
    });
    //remove follower
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove following
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove from notifications feeds
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  handleFollow() async {
    DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
    users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    setState(() {
      isFollowing = true;
    });
    //updates the followers collection of the followed user
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .set({});
    //updates the following collection of the currentUser
    followingRef
        .doc(currentUserId())
        .collection('userFollowing')
        .doc(widget.profileId)
        .set({});
    //update the notification feeds
    notificationRef
        .doc(widget.profileId)
        .collection('notifications')
        .doc(currentUserId())
        .set({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": users.username,
      "userId": users.user_id,
      "userDp": users.avatar_url,
      "timestamp": timestamp,
    });
  }

  buildPostView() {
    return buildGridPost();
  }

  buildGridPost() {
    // return StreamGridWrapper(
    //   shrinkWrap: true,
    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //   stream: postRef
    //       .where('ownerId', isEqualTo: widget.profileId)
    //       .orderBy('timestamp', descending: true)
    //       .snapshots(),
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemBuilder: (_, DocumentSnapshot snapshot) {
    //     PostModel posts =
    //         PostModel.fromJson(snapshot.data() as Map<String, dynamic>);
    //     return PostTile(
    //       post: posts,
    //     );
    //   },
    // );
  }

  buildLikeButton() {
    return StreamBuilder(
      stream: favUsersRef
          .where('postId', isEqualTo: widget.profileId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];
          return GestureDetector(
            onTap: () {
              if (docs.isEmpty) {
                favUsersRef.add({
                  'userId': currentUserId(),
                  'postId': widget.profileId,
                  'dateCreated': Timestamp.now(),
                });
              } else {
                favUsersRef.doc(docs[0].id).delete();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0,
                  )
                ],
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(
                  docs.isEmpty
                      ? CupertinoIcons.heart
                      : CupertinoIcons.heart_fill,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
