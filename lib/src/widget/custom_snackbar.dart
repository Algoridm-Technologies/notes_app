import 'package:flutter/material.dart';
import 'package:note/src/utils/constants.dart';

class CustomSnackBar {
  static showSnackbar({
    required BuildContext context,
    required String title,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor??kTextColor1,
      content: Text(title)));
  }
}
