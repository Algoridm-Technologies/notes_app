import 'package:flutter/material.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/outline_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: Center(
        child: OutlineButton(
          widget: const Text(
            "button",
            style: buttonPrimary,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
