import 'package:flutter/material.dart';
import 'package:hub_client/models/notification_model.dart';
import 'package:hub_client/services/firestore_services/app_notification_service.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: false);
    String? currentUserId = userState.uid;


    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 250,
        child: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF05182D),
                  Color(0xFF092A45),
                  Color(0xFF0D2339)
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'In App Notifications',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'For my Activities',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<NotificationModel>>(
                    stream: getNotifications(currentUserId!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final notifications = snapshot.data!;
                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                notification.userDp ?? '',
                              ),
                            ),
                            title: Text(
                              '${notification.username} ${notification.type}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              notification.commentData ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: Text(
                              timeago.format(
                                notification.timestamp!.toDate(),
                                locale: 'en_short',
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              // Handle notification onTap event
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
