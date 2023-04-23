import 'package:flutter/material.dart';
import 'package:hub_client/models/post_model.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/ui/widgets/common/custom_drawer.dart';
import 'package:hub_client/ui/widgets/feed/feed_app_bar.dart';
import 'package:hub_client/ui/widgets/feed/users_online.dart';
import 'package:hub_client/ui/widgets/post/post_detail.dart';
import 'package:hub_client/ui/widgets/who_to_follow/suggested_follows.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostView extends StatefulWidget {
  final PostModel post;
  const PostView({Key? key, required this.post}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openNotificationSidebar() {
    scaffoldKey.currentState?.openDrawer();
  }


   void _handleSearch(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<PostModel> _filterPosts(List<PostModel> posts) {
    if (selectedFilters.isEmpty && searchQuery.isEmpty) {
      return posts;
    }

    return posts.where((post) {
      final bool matchesFilter = selectedFilters.contains(post.description);
      final bool matchesSearch = post.description.contains(searchQuery);
      return matchesFilter && matchesSearch;
    }).toList();
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
    int notificationCount = 2; // Replace with actual count

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
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: null,
              automaticallyImplyLeading:false,
                flexibleSpace: FeedAppBar(
              openNotificationSidebar: openNotificationSidebar,
               onSearch: _handleSearch,
            )),
            body: Container(
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
              child: Row(
                  // FilterOptions(options: filterOptions)
                  children: [
                    const SuggestedUsersScreen(),
                    Expanded(child: PostDetailed(post: widget.post)),
                    UsersOnline(options: filterOptions)
                  ]),
            ),
            drawer: const CustomDrawer()));
  }

  @override
  bool get wantKeepAlive => true;
}
