import 'package:flutter/material.dart';

void handleErrors(BuildContext context, dynamic exception) {
  String message = exception.toString();

  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating, // Optional: makes it floating
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
