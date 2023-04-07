import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hub_client/ui/views/auth/login_page.dart';
import 'package:hub_client/ui/views/auth/register_page.dart';
import 'package:hub_client/ui/views/home/home_page.dart';
import 'package:hub_client/ui/views/profile/profile_page.dart';

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
            return const ProfilePge();
          },
        ),
      ],
    ),
  ],
);
