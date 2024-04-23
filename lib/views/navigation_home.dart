import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({Key? key});

  @override
  _NavigationHomeState createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoRouter.of(context).navigator,
    );
  }
}
