import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/ui/views/auth/login_page.dart';
import 'package:hub_client/ui/views/auth/register_page.dart';
import 'package:hub_client/ui/views/feed/create_post.dart';
import 'package:hub_client/ui/views/feed/feed_page.dart';
import 'package:hub_client/ui/views/home/home_page.dart';
// import 'package:hub_client/ui/views/profile/profile_page.dart';
import 'package:hub_client/ui/views/profile/profile_screen.dart';
import 'package:hub_client/ui/views/profileview/profile.dart';
import 'package:hub_client/utils/post_view.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterPage();
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileScreen();
          },
        ),
        GoRoute(
          path: 'profile/:uid', // add dynamic URL
          builder: (BuildContext context, GoRouterState state) {
            // extract the uid from the parameters
            final uid = state.params['uid'];
            return Profile(profileId: uid);
          },
        ),
        GoRoute(
          path: 'feeds',
          builder: (BuildContext context, GoRouterState state) {
            return const Feeds();
          },
        ),
        GoRoute(
          path: 'feeds/create_post',
          builder: (BuildContext context, GoRouterState state) {
            return ChangeNotifierProvider(
              create: (_) => PostsViewModel(),
              child: const CreatePostPage(),
            );
          },
        ),
      ],
    ),
  ],
);
