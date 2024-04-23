import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piaoxingqiu/models/user.dart';
import 'package:piaoxingqiu/services/shared_prefrences_service.dart';
import 'package:piaoxingqiu/views/shows_screen.dart';
import 'package:piaoxingqiu/views/show_detail_screen.dart';
import 'package:piaoxingqiu/views/user_profile_screen.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'views/login_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
              path: '/show',
              builder: (context, state) => const ShowsPage(),
              routes: [
                GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      var showId = state.pathParameters['id']!;
                      return ShowDetailPage(showId: showId);
                    }),
              ]),
          GoRoute(
            path: '/my',
            builder: (context, state) => UserProfilePage(),
          ),
        ]),
  ],
  redirect: (context, state) async {
    final isLoggedIn = (await SharedPreferencesService.getInstance()).isLogin;
    final goingToLogin = state.path == '/login';

    if (!isLoggedIn && !goingToLogin) return '/login';
    if (isLoggedIn && goingToLogin) {
      return '/show'; // Redirect logged in users trying to access login page
    }

    if (state.matchedLocation == '/') {
      return '/show';
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

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({required this.child, Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (v) => _onDestinationSelected(v, context),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.home,
              selectedIcon: Icon(Icons.home_outlined),
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: AppLocalizations.of(context)!.my,
              selectedIcon: Icon(Icons.person_outlined),
            )
          ],
        ));
  }

  void _onDestinationSelected(int destination, BuildContext context) {
    switch (destination) {
      case 0:
        GoRouter.of(context).go('/shows');
      case 1:
        GoRouter.of(context).go('/my');
      default:
        GoRouter.of(context).go('/shows');
    }
  }
}
