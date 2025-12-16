import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'pages/add_cv_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/set_account_page.dart';
import 'repo/state_providers.dart';
import 'widgets/dialog_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(authStateProvider).value;
  final account = ref.watch(accountProvider).value;
  return GoRouter(
    navigatorKey: _rootNavigatorKey, // root navigator for modals
    initialLocation: HomePage.routeName,
    routes: [
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: AddCvPage.routeName,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return DialogPage(builder: (_) => AddCvPage());
            },
          ),
        ],
      ),

      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: SetAccountPage.routeName,
        builder: (context, state) => const SetAccountPage(),
      ),
    ],
    redirect: (context, state) {
      if (user == null) {
        return LoginPage.routeName;
      }
      if (account == null) {
        return SetAccountPage.routeName;
      }
      return null;
    },
  );
});
