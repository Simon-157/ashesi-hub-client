import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/components/custome_button.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/firestore_services/follow_user_service.dart';
import 'package:hub_client/services/firestore_services/profile_services.dart';
import 'package:hub_client/ui/views/profileview/profile_buttons.dart';
import 'package:hub_client/ui/views/profileview/profile_details.dart';
import 'package:hub_client/ui/widgets/profile/profile_post_grid.dart';
import 'package:hub_client/services/auth/firebase_auth.dart';
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
  late UserModel student;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  unFollow() async {
    Stream<DocumentSnapshot> userStream = ProfileService.getUserSnapshot(ProfileService.currentUserId());
    userStream.listen((DocumentSnapshot doc) {
      student = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    });

    setState(() {
      isFollowing = false;
    });

    await FollowService.handleUnfollowDeletion(widget.profileId);
  }

  Follow() async {
    Stream<DocumentSnapshot> userStream = ProfileService.getUserSnapshot(ProfileService.currentUserId());
    userStream.listen((DocumentSnapshot doc) {
      student = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    });

    setState(() {
      isFollowing = true;
    });

    await FollowService.handleFollowUpdate(widget.profileId, student);
  }

  @override
  void initState() {
    super.initState();
    checkUserFollowing();
  }

  void checkUserFollowing() async {
    bool result = await ProfileService.isUserFollowing(widget.profileId!);
    setState(() {
      isFollowing = result;
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
                        child: InkWell(
                          mouseCursor: MaterialStateMouseCursor.clickable,
                          // child: GestureDetector(
                          onTap: () {
                            signOut(context);
                            context.go('/');
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
                                      stream: ProfileService.getUserPostsSnapshot(
                                          widget.profileId!),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          QuerySnapshot<Object?>? snap =
                                              snapshot.data;
                                          List<DocumentSnapshot> docs =
                                              snap!.docs;
                                          return actionCount(
                                              "POSTS", docs.length);
                                        } else {
                                          return actionCount("POSTS", 0);
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
                                      stream: ProfileService.getUserFollowersSnapshot(
                                          widget.profileId!),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          QuerySnapshot<Object?>? snap =
                                              snapshot.data;
                                          List<DocumentSnapshot> docs =
                                              snap!.docs;
                                          return actionCount(
                                              "FOLLOWERS", docs.length);
                                        } else {
                                          return actionCount("FOLLOWER", 0);
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
                                      stream: ProfileService.getUserFollowingSnapshot(
                                          widget.profileId!),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          QuerySnapshot<Object?>? snap =
                                              snapshot.data;
                                          List<DocumentSnapshot> docs =
                                              snap!.docs;
                                          return actionCount(
                                              "FOLLOWING", docs.length);
                                        } else {
                                          return actionCount("FOLLOWING", 0);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                profileActionButton(
                                    user,
                                    isFollowing,
                                    widget.profileId!,
                                    context,
                                    Follow,
                                    unFollow),
                                const SizedBox(
                                  width: 10,
                                ),
                                profilePostsButton(
                                    user,
                                    isFollowing,
                                    widget.profileId!,
                                    context,
                                    Follow,
                                    unFollow),
                                const SizedBox(
                                  width: 10,
                                ),
                                profileLikesButton(
                                    user,
                                    isFollowing,
                                    widget.profileId!,
                                    context,
                                    Follow,
                                    unFollow)
                              ],
                            ))
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
              // TODO SILVER DELEGATES TO SHOW POSTS MADE BY THIS USER
              // ProfilePostsGrid(profileId: widget.profileId)
              SliverToBoxAdapter(
                child: ProfilePostsGrid(
                  profileId: widget.profileId,
                ),
              )
            ],
          ),
        ));
  }
}
