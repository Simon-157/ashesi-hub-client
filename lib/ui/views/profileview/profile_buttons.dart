import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hub_client/components/custome_button.dart';
import 'package:hub_client/ui/views/profileview/full_user_details.dart';
import 'package:hub_client/ui/widgets/profile/profile_edit_dialog.dart';
import 'package:hub_client/utils/firebase_collections.dart';

/// This function returns a button with different text and functionality based on whether the user is
/// following another user or if it is the user's own profile.
profileActionButton(user, isFollowing, String id, BuildContext context,
    Function()? follow, unFollow) {
  bool isMe = id == firebaseAuth.currentUser!.uid;
  if (isMe) {
    return actionButton(
        text: "Edit Profile",
        function: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (_) => EditProfile(
              user: user,
            ),
          ));
        },
        context: context);
  } else if (isFollowing) {
    return actionButton(text: "Unfollow", function: unFollow, context: context);
  } else if (!isFollowing) {
    return actionButton(text: "Follow", function: follow, context: context);
  }
}

/// This function returns a button with different text and functionality based on whether the user is
/// following the profile, if it's the user's own profile, or if they are not following the profile.
/// Returns:
///   The function `profileLikesButton` returns a widget that displays a button with different text and
/// functionality based on the input parameters.
profileLikesButton(user, isFollowing, String id, BuildContext context,
    Function()? follow, unFollow) {
  bool isMe = id == firebaseAuth.currentUser!.uid;
  if (isMe) {
    return actionButton(
        text: "Likes",
        function: () {
          Navigator.of(context).push(CupertinoPageRoute(
            builder: (_) => EditProfile(
              user: user,
            ),
          ));
        },
        context: context);
  } else if (isFollowing) {
    return actionButton(text: "Unfollow", function: unFollow, context: context);
  } else if (!isFollowing) {
    return actionButton(text: "Follow", function: follow, context: context);
  }
}
