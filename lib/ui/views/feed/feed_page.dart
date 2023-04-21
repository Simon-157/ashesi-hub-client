import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/services/firestore_services/app_notification_service.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/ui/widgets/common/custom_drawer.dart';
import 'package:hub_client/ui/widgets/feed/feed_nav.dart';
import 'package:hub_client/ui/widgets/feed/filter_options.dart';
import 'package:hub_client/ui/widgets/post/post.dart';
import 'package:hub_client/ui/widgets/feed/users_online.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:hub_client/widgets/loaders.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feeds extends StatefulWidget {
  Feeds({Key? key}) : super(key: key);
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openNotificationSidebar() {
    scaffoldKey.currentState?.openDrawer();
  }

  int page = 5;
  bool loadingMore = false;
  ScrollController scrollController = ScrollController();
  SharedPreferences? prefs;
  final List<String> filterOptions = [
    'All',
    'Popular',
    'Recent',
    'Favorites',
    'images',
    'videos',
    'entertainment',
    'beauty'
  ];
  Set<String> selectedFilters = {};
  String searchQuery = "";
  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
      
          page = page + 20;
          loadingMore = true;
          prefs = await SharedPreferences.getInstance();
        });
      }
    });
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context, listen: false);
    String? currentUserId = userState.uid;

    print("feed uid $currentUserId ");

    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF05182D), Color(0xFF092A45), Color(0xFF0D2339)],
        ),
      ),
      // ignore: sort_child_properties_last
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
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
              // firebaseAuth.currentUser != null,
              currentUserId != null
                  ? FeedBar(
                    
                      currentUserId: currentUserId,
                      openNotificationSidebar: openNotificationSidebar, getTotalNotifications: getTotalUserNotifications)
                  : FeedBar(
                    getTotalNotifications: getTotalUserNotifications,
                      currentUserId: currentUserId,
                      openNotificationSidebar: openNotificationSidebar)
            ],
          ),
          body: RefreshIndicator(
            // color: Theme.of(context).colorScheme.secondary,
            onRefresh: () => postRef
                .orderBy('timestamp', descending: true)
                .limit(page)
                .get(),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  FilterOptions(options: filterOptions),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: postRef
                            .orderBy('timestamp', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var docs = snapshot.data!.docs;
                            return ListView.builder(
                              controller: scrollController,
                              itemCount: docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                PostModel posts = PostModel.fromJson(
                                    docs[index].data() as Map<String, dynamic>);
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: UserPost(post: posts),
                                );
                              },
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return circularProgress(context);
                          } else {
                            return const Center(
                              child: Text(
                                'No Feeds',
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Column(children: [UsersOnline(options: filterOptions)])
                ],
              ),
            ),
          ),
          drawer: const CustomDrawer()),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
