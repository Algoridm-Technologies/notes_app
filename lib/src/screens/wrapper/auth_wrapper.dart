import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note/src/screens/employee_screens/employee_main/employee_main_page.dart';
import 'package:note/src/screens/employer_screens/employer_main/employer_main_page.dart';
import 'package:note/src/screens/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/refresh.dart';
import '../../utils/constants.dart';

class AuthWrapper extends StatefulWidget {
  final bool isEmployer;
  const AuthWrapper({Key? key, required this.isEmployer}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    RefreshApi.refresh().then((value) async {
   
      if (jsonDecode(value)['error'] != null) {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: kAnimationDuration,
            pageBuilder: ((context, animation, _) {
              return FadeTransition(
                opacity: animation,
                child: const LoginPage(),
              );
            }),
          ),
        );
      } else {
           var prefs = await SharedPreferences.getInstance();
    prefs.setString("refresh", jsonDecode(value)['refresh']);
    prefs.setString("token", jsonDecode(value)['access']);
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: kAnimationDuration,
            pageBuilder: ((context, animation, _) {
              return FadeTransition(
                opacity: animation,
                child: widget.isEmployer
                    ? const EmployerMainPage()
                    : const EmployeeMainPage(),
              );
            }),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
