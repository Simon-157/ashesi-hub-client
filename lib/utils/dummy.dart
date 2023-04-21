// firebaseAuth.currentUser != null
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                           IconButton(
//                             tooltip: "chats",
//                             icon: const Icon(
//                               Icons.chat_bubble,
//                               size: 30.0,
//                             ),
//                             onPressed: () {
//                               context.go('/chats/chat_id');
//                             },
//                           ),
//                           const SizedBox(width: 20.0),
//                           IconButton(
//                             tooltip: "create post",
//                             icon: const Icon(
//                               Icons.post_add,
//                               size: 30.0,
//                             ),
//                             onPressed: () {
//                               // context.go('/feeds/create_post');

//                               showDialog(
//                                 context: context,
//                                 builder: (_) => const CreatePostDialog(),
//                               );
//                             },
//                           ),
//                           const SizedBox(width: 20.0),
//                           Stack(
//                             children: [
//                               IconButton(
//                                   tooltip: "notifications",
//                                   icon: const Icon(
//                                     Icons.notifications_active_rounded,
//                                     size: 30.0,
//                                   ),
//                                   onPressed: () => {openNotificationSidebar()}),
//                               if (notificationCount > 0)
//                                 Positioned(
//                                   top: 0,
//                                   right: 0,
//                                   child: Container(
//                                     padding: const EdgeInsets.all(4.0),
//                                     decoration: const BoxDecoration(
//                                       color: Colors.red,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Text(
//                                       notificationCount.toString(),
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           const SizedBox(width: 20.0),
//                           Tooltip(
//                             message: "View Profile",
//                             preferBelow: false,
//                             child: InkWell(
//                               onTap: () {
//                                 // Navigate to the user profile screen
//                                 context.go('/profile/$currentUserId');
//                               },
//                               child: StreamBuilder<DocumentSnapshot>(
//                                 stream: ProfileService.getUserSnapshot(
//                                     firebaseAuth.currentUser!.uid),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.hasError) {
//                                     return const Icon(Icons.error);
//                                   }
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return const CircularProgressIndicator();
//                                   } else {
//                                     final userDoc = snapshot.data!;
//                                     final avatarUrl =
//                                         userDoc.get('avatar_url') as String?;

//                                     return CircleAvatar(
//                                       radius: 15.0,
//                                       backgroundImage: NetworkImage(avatarUrl!),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20.0),
//                           IconButton(
//                             tooltip: "logout",
//                             mouseCursor: MaterialStateMouseCursor.clickable,
//                             padding: const EdgeInsets.only(right: 5.0),
//                             onPressed: () {
//                               signOut(context);
//                               context.go('/');
//                             },
//                             icon: const Icon(
//                               Icons.logout,
//                               size: 30.0,
//                             ),
//                           ),
//                         ])
//                   : IconButton(
//                       tooltip: "login",
//                       mouseCursor: MaterialStateMouseCursor.clickable,
//                       padding: const EdgeInsets.only(right: 5.0),
//                       onPressed: () {
//                         context.go('/login');
//                       },
//                       icon: const Icon(
//                         Icons.login,
//                         size: 30.0,
//                       ),
//                     ),
//               const SizedBox(width: 20.0),