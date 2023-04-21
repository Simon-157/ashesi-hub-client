import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/services/firestore_services/app_notification_service.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/ui/widgets/feed/feed_nav.dart';
import 'package:provider/provider.dart';

class FeedAppBar extends StatelessWidget {
    final Function openNotificationSidebar;
  const FeedAppBar({
    Key? key, required this.openNotificationSidebar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final userState = Provider.of<UserState>(context, listen: false);
    String? currentUserId = userState.uid;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF092A45),
      title: Row(
        children: [
          IconButton(
            tooltip: "home",
            onPressed: () {
              context.go('/');
            },
            icon: Image.asset(
              'images/logo_ashesi.png',
              width: 50,
              height: 50,
            ),
          ),
          const Text(
            "ashHUb",
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
      centerTitle: true,
      actions: [
        currentUserId != null
            ? FeedBar(
                currentUserId: currentUserId,
                openNotificationSidebar: openNotificationSidebar,
                getTotalNotifications: getTotalUserNotifications)
            : FeedBar(
                getTotalNotifications: getTotalUserNotifications,
                currentUserId: currentUserId,
                openNotificationSidebar: openNotificationSidebar)
      ],
    );
  }
}
