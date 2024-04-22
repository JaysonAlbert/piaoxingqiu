import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piaoxingqiu/models/user.dart';
import 'package:piaoxingqiu/services/shared_prefrences_service.dart';
import 'package:piaoxingqiu/views/shows_screen.dart';
import 'package:piaoxingqiu/views/show_detail_screen.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'views/login_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/shows',
      builder: (context, state) => const ShowsPage(),
    ),
    GoRoute(
        path: '/show/:id',
        builder: (context, state) {
          var showId = state.pathParameters['id']!;
          return ShowDetailPage(showId: showId);
        })
  ],
  redirect: (context, state) async {
    final isLoggedIn = (await SharedPreferencesService.getInstance()).isLogin;
    final goingToLogin = state.path == '/login';

    if (!isLoggedIn && !goingToLogin) return '/login';
    if (isLoggedIn && goingToLogin) {
      return '/shows'; // Redirect logged in users trying to access login page
    }

    if (state.matchedLocation == '/') {
      return '/shows';
    }

    return null;
  },
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'piaoxingqiu',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
            textTheme: TextTheme(
                headlineSmall: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ))),
      ),
    );
  }
}
