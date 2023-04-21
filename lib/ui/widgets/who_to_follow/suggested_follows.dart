import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/firestore_services/profile_services.dart';
import 'package:hub_client/utils/firebase_collections.dart';

class SuggestedUsersScreen extends StatefulWidget {
  const SuggestedUsersScreen({Key? key}) : super(key: key);

  @override
  _SuggestedUsersScreenState createState() => _SuggestedUsersScreenState();
}

class _SuggestedUsersScreenState extends State<SuggestedUsersScreen> {
  // late List<UserModel> _suggestedUsers;
  List<UserModel> _suggestedUsers = [];
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _getSuggestedUsers();
  }

  void _getSuggestedUsers() async {
    List<UserModel> users = []; // List of UserModel
    List<DocumentSnapshot> snapshotList =
        await ProfileService.getSuggestedUsers();
    snapshotList.forEach((snapshot) {
      UserModel user = UserModel.fromSnapshot(snapshot);
      users.add(user);
    });
    setState(() {
      _suggestedUsers = users;
    });
  }

  void _followUser() {
    // Do something when the user is followed
    setState(() {
      _isFollowing = true;
    });
  }

  void _unfollowUser() {
    // Do something when the user is unfollowed
    setState(() {
      _isFollowing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300, // Set width constraint
        height: 300,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Suggested Students based on major",
                style: TextStyle(
                    color: Color.fromARGB(255, 114, 229, 210),
                    fontSize: 16,
                    fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: _suggestedUsers.length,
                  itemBuilder: (context, index) {
                    UserModel user = _suggestedUsers[index];
                    bool isMe = user.user_id == firebaseAuth.currentUser!.uid;
                    if (isMe) {
                      return const SizedBox();
                    } else {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(user.avatar_url),
                        ),
                        title: Text(
                          user.username,
                          style: const TextStyle(
                              color: Color.fromARGB(232, 230, 245, 243),
                              fontSize: 16,
                              fontWeight: FontWeight.w200),
                        ),
                        subtitle: Text(
                          user.major,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 89, 155, 144),
                              fontSize: 16,
                              fontWeight: FontWeight.w200),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: profileActionButton(
                          user: user,
                          isFollowing: _isFollowing,
                          context: context,
                          follow: _followUser,
                          unFollow: _unfollowUser,
                        ),
                      );
                    }
                  },
                ),
              )
            ]));
  }

  Widget profileActionButton({
    required UserModel user,
    required bool isFollowing,
    required BuildContext context,
    Function()? follow,
    Function()? unFollow,
  }) {
    if (isFollowing) {
      return ElevatedButton(
        onPressed: unFollow,
        child: const Text("Unfollow"),
      );
    } else if (!isFollowing) {
      return ElevatedButton(
        onPressed: follow,
        child: const Text("Follow"),
      );
    }
    return const SizedBox.shrink();
  }
}
