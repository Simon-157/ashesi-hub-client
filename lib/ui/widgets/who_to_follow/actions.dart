// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:hub_client/models/user_model.dart';
// import 'package:hub_client/services/firestore_services/profile_services.dart';

// unFollow() async {
//     Stream<DocumentSnapshot> userStream =
//         ProfileService.getUserSnapshot(ProfileService.currentUserId());
//     userStream.listen((DocumentSnapshot doc) {
//       student = UserModel.fromJson(doc.data() as Map<String, dynamic>);
//     });

//     setState(() {
//       isFollowing = false;
//     });

//     await FollowService.handleUnfollowDeletion(widget.profileId);
//   }

//   Follow() async {
//     Stream<DocumentSnapshot> userStream =
//         ProfileService.getUserSnapshot(ProfileService.currentUserId());
//     userStream.listen((DocumentSnapshot doc) {
//       student = UserModel.fromJson(doc.data() as Map<String, dynamic>);
//     });

//     setState(() {
//       isFollowing = true;
//     });

//     await FollowService.handleFollowUpdate(widget.profileId, student);
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkUserFollowing();
//   }

//   void checkUserFollowing() async {
//     bool result = await ProfileService.isUserFollowing(widget.profileId!);
//     setState(() {
//       isFollowing = result;
//     });
//   }