import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String userName = '';
  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) => setState(() => userName = value),
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            onChanged: (value) => setState(() => userEmail = value),
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
        ],
      ),
    );
  }
}
