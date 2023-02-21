import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/database/employee_note_provider.dart';
import 'package:note/src/provider/database/profile_detail_provider.dart';
import 'package:note/src/provider/navigation/employee_navigation_provider.dart';
import 'package:note/src/screens/employee_screens/employee_home/employee_home_page.dart';
import 'package:note/src/screens/employee_screens/employee_notes/employee_notes_page.dart';
import 'package:note/src/screens/employee_screens/employee_profile/employee_profile_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../provider/database/access_provider.dart';
import '../../../provider/database/notification_provider.dart';
import '../../../utils/refresh_token.dart';

class EmployeeMainPage extends StatefulWidget {
  const EmployeeMainPage({Key? key}) : super(key: key);

  @override
  State<EmployeeMainPage> createState() => _EmployeeMainPageState();
}

class _EmployeeMainPageState extends State<EmployeeMainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      refreshAndFetchData();
    });
  }

  refreshAndFetchData() async {
    await RefreshToken.refreshToken().then((value) {
      Provider.of<AccessProvider>(context, listen: false).setAccess();
      Provider.of<ProfileDetailProvider>(context, listen: false)
          .getDetails();
        
      Provider.of<EmployeeNoteProvider>(context, listen: false)
          .getNotesAndEmployee();
      Provider.of<NotificationProvider>(context, listen: false).getFacility();
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      const EmployeeHomePage(),
      const EmployeeNotesPage(),
      const EmployeeProfilePage(),
    ];
    return Consumer<EmployeeNavigationProvider>(
      builder: (context, value, child) {
        return WillPopScope(
          onWillPop: () async {
            if (value.currentPosition == 0) {
              return true;
            } else {
              value.changePage(0);
              return false;
            }
          },
          child: Scaffold(
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
                items: const [
                  BottomNavigationBarItem(
                      label: "Home",
                      icon: Icon(
                        Iconsax.home,
                      )),
                  BottomNavigationBarItem(
                      label: "Notes",
                      icon: Icon(
                        Iconsax.note_21,
                      )),
                  BottomNavigationBarItem(
                      label: "Profile",
                      icon: Icon(
                        Iconsax.user,
                      )),
                ]),
          ),
        );
      },
    );
  }
}
