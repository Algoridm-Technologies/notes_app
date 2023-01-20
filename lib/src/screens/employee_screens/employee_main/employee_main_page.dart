import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/navigation/navigation_provider.dart';
import 'package:note/src/screens/employee_screens/employee_home/employee_home_page.dart';
import 'package:note/src/screens/employee_screens/employee_notes/employee_notes_page.dart';
import 'package:note/src/screens/employee_screens/employee_profile/employee_profile_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

class EmployeeMainPage extends StatelessWidget {
  const EmployeeMainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var pages = [
      const EmployeeHomePage(),
      const EmployeeNotesPage(),
      const EmployeeProfilePage(),
    ];
    return Consumer<NavigationProvider>(
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
        );
      },
    );
  }
}
