/// This is a router configuration for a Flutter app with different routes for authentication, home,
/// login, registration, feeds, and user profiles.
/// 
/// Returns:
///   The `router` object is being returned, which is an instance of the `GoRouter` class.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/state_management/user_state.dart';
import 'package:hub_client/ui/views/auth/login_page.dart';
import 'package:hub_client/ui/views/auth/register_page.dart';
import 'package:hub_client/ui/views/feed/feed_page.dart';
import 'package:hub_client/ui/views/home/home_page.dart';
import 'package:hub_client/ui/views/profileview/profile_page.dart';
import 'package:hub_client/ui/widgets/who_to_follow/suggested_follows.dart';
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
          path: 'try',
          builder: (BuildContext context, GoRouterState state) {
            return SuggestedUsersScreen();
          },
        ),
        GoRoute(
          path: 'upgrade_profile',
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
