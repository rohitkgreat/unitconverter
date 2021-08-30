import 'package:flutter/material.dart';

const buttonsBackgroundColor = Color(0xFF090E1C);
const backgroundColor = Color(0xFF141A2F);
const yellowColor = Color(0xFFF7CF32);
const whiteColor = Colors.white;

AppBar appbar(
  BuildContext context,
  String title,
  IconData icon,
  Function() tap,
) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
    actions: [
      IconButton(
        onPressed: tap,
        icon: Icon(icon),
      ),
    ],
  );
}

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 400),
    ),
  );
}
