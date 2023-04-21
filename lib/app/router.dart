import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/ui/views/auth/login_page.dart';
import 'package:hub_client/ui/views/auth/register_page.dart';
import 'package:hub_client/ui/views/feed/feed_page.dart';
import 'package:hub_client/ui/views/home/home_page.dart';
import 'package:hub_client/ui/views/profileview/profile_page.dart';
import 'package:hub_client/providers/post_view.dart';
import 'package:hub_client/utils/firebase_collections.dart';
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
        final userState = Provider.of<UserState>(context, listen: false);
        userState.setUser(
            firebaseAuth.currentUser?.uid, firebaseAuth.currentUser?.email);
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
          path: 'feeds',
          builder: (BuildContext context, GoRouterState state) {
            return Feeds();
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
              print("route param ----------$uid");
              return Profile(profileId: uid);
            } else {
              return const LoginPage();
            }
          },
        ),
      ],
    ),
  ],
);
