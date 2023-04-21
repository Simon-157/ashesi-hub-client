// Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () => context.go('/'),
//                       child: const Text(
//                         'aShesHUb',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),

//                     Row(
//                       children: <ElevatedButton>[
//                         ElevatedButton(
//                           onPressed: () => context.go('/login'),
//                           child: const Text('Sign ',
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                         ElevatedButton(
//                           onPressed: () => context.go('/'),
//                           child: const Text('Status',
//                               style: TextStyle(color: Color(0xFF6F92B6))),
//                         ),
//                         ElevatedButton(
//                           onPressed: () => context.go('/'),
//                           child: const Text('Feed',
//                               style: TextStyle(color: Color(0xFF6F92B6))),
//                         ),
//                       ],
//                     )
//                     // Icon(Icons.search, color: Colors.white),
//                   ],
//                 ),




  // buildLikeButton() {
  //   return StreamBuilder(
  //     stream: favUsersRef
  //         .where('postId', isEqualTo: widget.profileId)
  //         .where('userId', isEqualTo: currentUserId())
  //         .snapshots(),
  //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasData) {
  //         List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];
  //         return GestureDetector(
  //           onTap: () {
  //             if (docs.isEmpty) {
  //               favUsersRef.add({
  //                 'userId': currentUserId(),
  //                 'postId': widget.profileId,
  //                 'dateCreated': Timestamp.now(),
  //               });
  //             } else {
  //               favUsersRef.doc(docs[0].id).delete();
  //             }
  //           },
  //           child: Container(
  //             decoration: BoxDecoration(
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.2),
  //                   spreadRadius: 3.0,
  //                   blurRadius: 5.0,
  //                 )
  //               ],
  //               color: Colors.white,
  //               shape: BoxShape.circle,
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(3.0),
  //               child: Icon(
  //                 docs.isEmpty
  //                     ? CupertinoIcons.heart
  //                     : CupertinoIcons.heart_fill,
  //                 color: Colors.red,
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //       return Container();
  //     },
  //   );
  // }