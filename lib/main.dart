import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piaoxingqiu/models/user.dart';
import 'package:piaoxingqiu/views/shows_screen.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'views/login_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(path: '/shows', builder: (context, state) => const ShowsPage())
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
    );
  }
}
