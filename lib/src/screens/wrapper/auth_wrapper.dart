import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note/src/screens/launch/launch_page.dart';
import 'package:note/src/screens/wrapper/facility_wrapper.dart';
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
      log(value.toString());
      if (value == "Error") {}
      if (jsonDecode(value)['error'] != null) {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
              transitionDuration: kAnimationDuration,
              pageBuilder: ((context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: const LaunchPage(),
                );
              }),
            ),
            (Route<dynamic> route) => false);
      } else {
        SharedPreferences.getInstance().then((v) {
          v.setString("refresh", jsonDecode(value)['refresh']);
          v.setString("token", jsonDecode(value)['access']);
          Navigator.of(context).pushAndRemoveUntil(
              PageRouteBuilder(
                transitionDuration: kAnimationDuration,
                pageBuilder: ((context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const FacilityWrapper(),
                  );
                }),
              ),
              (Route<dynamic> route) => false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Hero(tag: "progress", child: CircularProgressIndicator())),
    );
  }
}
