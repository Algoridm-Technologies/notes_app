import 'package:flutter/material.dart';

class CustomSnackBar {
  static showSnackbar({required BuildContext context,required String title }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }
}
