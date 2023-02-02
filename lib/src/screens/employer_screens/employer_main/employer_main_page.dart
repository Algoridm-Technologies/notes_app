import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:note/src/api/refresh.dart';
import 'package:note/src/provider/navigation/employer_navigation_provider.dart';
import 'package:note/src/screens/facilities/facilities_page.dart';
import 'package:note/src/screens/staffs/staffs_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/access_model.dart';
import '../../../provider/database/access_provider.dart';
import '../employer_home/employer_home_page.dart';
import '../employer_notes/employer_notes_page.dart';
import '../employer_profile/employer_profile_page.dart';

class EmployerMainPage extends StatefulWidget {
  const EmployerMainPage({Key? key}) : super(key: key);

  @override
  State<EmployerMainPage> createState() => _EmployerMainPageState();
}

class _EmployerMainPageState extends State<EmployerMainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AccessProvider>(context, listen: false).setModel();
    });
  }

  refreshAndFetchData() async {
    // var refresh = await RefreshApi.refresh();

    // var prefs = await SharedPreferences.getInstance();
    // prefs.setString("refresh", jsonDecode(refresh)['refresh']);
    // prefs.setString("token", jsonDecode(refresh)['access']);
    // var token = prefs.getString("token") ?? "";

    // Map<String, dynamic> data = Jwt.parseJwt(token);

    //   Provider.of<AccessProvider>(context, listen: false)
    //       .setModel(AccessModel.fromMap(data));
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      const EmployerHomePage(),
      const EmployerStaffsPage(),
      const EmployerFacilitiesPage(),
      const EmployerNotesPage(),
      const EmployerProfilePage(),
    ];
    return Consumer<EmployerNavigationProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: pages[value.currentPosition],
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: kPrimaryColor1,
              unselectedItemColor: kGreyColor,
              onTap: (v) {
                value.changePage(v);
              },
              currentIndex: value.currentPosition,
              type: BottomNavigationBarType.fixed,
              items: [
                const BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(
                      Iconsax.home,
                    )),
                BottomNavigationBarItem(
                  label: "Staffs",
                  icon: SvgPicture.asset(
                    'assets/icons/Vector(1).svg',
                    color: value.currentPosition == 1
                        ? kPrimaryColor1
                        : kGreyColor,
                  ),
                ),
                const BottomNavigationBarItem(
                    label: "Facilities",
                    icon: Icon(
                      Iconsax.category,
                    )),
                const BottomNavigationBarItem(
                    label: "Notes",
                    icon: Icon(
                      Iconsax.note_21,
                    )),
                const BottomNavigationBarItem(
                    label: "Profile",
                    icon: Icon(
                      Iconsax.user,
                    )),
              ]),
        );
      },
    );
  }
}
