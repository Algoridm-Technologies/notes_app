import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note/src/screens/choose_facility/choose_facility_page.dart';
import 'package:note/src/screens/employee_screens/employee_main/employee_main_page.dart';
import 'package:note/src/screens/employer_screens/employer_main/employer_main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/profile_detail_api.dart';
import '../../api/refresh.dart';
import '../../utils/constants.dart';

class FacilityWrapper extends StatefulWidget {
  const FacilityWrapper({
    Key? key,
  }) : super(key: key);

  @override
  State<FacilityWrapper> createState() => _FacilityWrapperState();
}

class _FacilityWrapperState extends State<FacilityWrapper> {
  @override
  void initState() {
    super.initState();
    // init();
  }

  init() async {
    RefreshApi.refresh().then((value) async {
      if (value == "Error") {}
      await ProfileDetailApi.getProfileDetail().then((va) {
        log(value);
        SharedPreferences.getInstance().then((v) {
          v.setString("refresh", jsonDecode(value)['refresh']);
          v.setString("token", jsonDecode(value)['access']);
          var isEmployer = v.getBool('isEmployer') ?? false;
          if (jsonDecode(va)['facility'] == null) {
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  transitionDuration: kAnimationDuration,
                  pageBuilder: ((context, animation, _) {
                    return FadeTransition(
                      opacity: animation,
                      child: const ChooseFacilityPage(),
                    );
                  }),
                ),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  transitionDuration: kAnimationDuration,
                  pageBuilder: ((context, animation, _) {
                    return FadeTransition(
                      opacity: animation,
                      child: isEmployer
                          ? const EmployerMainPage()
                          : const EmployeeMainPage(),
                    );
                  }),
                ),
                (Route<dynamic> route) => false);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                  child: IconButton(
                      onPressed: () => setState(() {}),
                      icon: const Center(child: CircularProgressIndicator())));
            }
          }),
    );
  }
}
