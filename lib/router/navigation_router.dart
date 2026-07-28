import 'package:co_works/forgot_password/forgot_password_screen.dart';
import 'package:co_works/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPasswordScreen();
      },
    ),
  ],
);
