/// The FeedAppBar class is a stateless widget that displays the app bar for the feed page, including a
/// logo, search bar, and notification icon.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/services/firestore_services/app_notification_service.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/ui/widgets/feed/feed_nav.dart';
import 'package:provider/provider.dart';


class FeedAppBar extends StatelessWidget {
  final Function openNotificationSidebar;
  final ValueChanged<String> onSearch;

  const FeedAppBar({
    Key? key,
    required this.openNotificationSidebar,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: false);
    String? currentUserId = userState.uid;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF092A45),
      title: SizedBox(
        height: kToolbarHeight,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
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
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: 200,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: TextField(
                    style: const TextStyle(
                        color: Color.fromARGB(255, 187, 227, 229)),
                    decoration: InputDecoration(
                      focusColor: Color.fromARGB(255, 220, 254, 250),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(198, 33, 149, 243),
                      ),
                      suffixIcon: const Icon(
                        Icons.send,
                        color: Color.fromARGB(190, 33, 149, 243),
                      ),
                      fillColor: const Color.fromARGB(217, 9, 42, 69),
                      hintText: 'Search ...',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 219, 238, 240)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          color: Color.fromARGB(
                              255, 182, 13, 29), // change the color here
                        ),
                      ),
                      filled: true,
                    ),
                    onChanged: onSearch,
                  ),
                ),
              ),
            ),
          ],
        ),
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
                openNotificationSidebar: openNotificationSidebar),
      ],
    );
  }
}
