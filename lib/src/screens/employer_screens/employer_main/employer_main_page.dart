import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/navigation/employer_navigation_provider.dart';
import 'package:note/src/screens/facilities/facilities_page.dart';
import 'package:note/src/screens/staffs/staffs_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

import '../employer_home/employer_home_page.dart';
import '../employer_notes/employer_notes_page.dart';
import '../employer_profile/employer_profile_page.dart';

class EmployerMainPage extends StatelessWidget {
  const EmployerMainPage({Key? key}) : super(key: key);
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
