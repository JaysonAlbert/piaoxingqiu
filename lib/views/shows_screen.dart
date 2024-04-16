import 'package:flutter/material.dart';

class ShowsPage extends StatelessWidget {
  const ShowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Center(child: Text('Shows'));
        },
      ),
    );
  }
}
