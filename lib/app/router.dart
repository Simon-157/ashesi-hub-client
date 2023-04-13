import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/ui/views/auth/login_page.dart';
import 'package:hub_client/ui/views/auth/register_page.dart';
import 'package:hub_client/ui/views/feed/create_post.dart';
import 'package:hub_client/ui/views/feed/feed_page.dart';
import 'package:hub_client/ui/views/home/home_page.dart';
import 'package:hub_client/ui/views/profileview/profile_page.dart';
import 'package:hub_client/providers/post_view.dart';
import 'package:hub_client/ui/widgets/common/image_upload.dart';
import 'package:provider/provider.dart';

bool isAuthenticated() {
  User? user = FirebaseAuth.instance.currentUser;
  return user != null;
}

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
          path: 'try',
          builder: (BuildContext context, GoRouterState state) {
            return const ImageUploader();
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterPage();
          },
        ),
        GoRoute(
          path: 'profile/edit/:uid',
          builder: (BuildContext context, GoRouterState state) {
            if (isAuthenticated()) {
              final uid = state.params['uid'];
              return Profile(profileId: uid);
            } else {
              return const LoginPage();
            }
          },
        ),
        GoRoute(
          path: 'profile/:uid',
          builder: (BuildContext context, GoRouterState state) {
            if (isAuthenticated()) {
              final uid = state.params['uid'];
              return Profile(profileId: uid);
            } else {
              return const LoginPage();
            }
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
            if (isAuthenticated()) {
              return ChangeNotifierProvider(
                create: (_) => PostsViewModel(),
                child: const CreatePostPage(),
              );
            } else {
              return const LoginPage();
            }
          },
        ),
      ],
    ),
  ],
);
