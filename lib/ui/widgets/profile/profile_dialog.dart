import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/utils/authentication.dart';

class UserProfileTooltip extends StatefulWidget {
  final String username;
  final String profileImageURL;
  final String bio;
  final Widget child;

  UserProfileTooltip({
    this.username,
    this.profileImageURL,
    this.bio,
    this.child,
  });

  @override
  _UserProfileTooltipState createState() => _UserProfileTooltipState();
}

class _UserProfileTooltipState extends State<UserProfileTooltip> {
  void _showProfileCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.username),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: widget.profileImageURL.isNotEmpty
                    ? NetworkImage(widget.profileImageURL)
                    : null,
                child: widget.profileImageURL.isEmpty
                    ? const Icon(
                        Icons.account_circle,
                        size: 60,
                      )
                    : Container(),
              ),
              const SizedBox(height: 10),
              Text(widget.bio),
              const SizedBox(height: 10),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.blueGrey[800]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () => {context.go('/profile/$uid')},
                child: const Text('View My Profile'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'View profile',
      child: GestureDetector(
        onTap: () {
          _showProfileCard(context);
        },
        child: widget.child,
      ),
    );
  }
}
