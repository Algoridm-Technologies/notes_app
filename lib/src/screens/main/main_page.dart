import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/navigation/navigation_provider.dart';
import 'package:note/src/screens/facilities/facilities_page.dart';
import 'package:note/src/screens/home/home_page.dart';
import 'package:note/src/screens/notes/notes_page.dart';
import 'package:note/src/screens/profile/profile_page.dart';
import 'package:note/src/screens/staffs/staffs_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var pages = [
      const HomePage(),
      const StaffsPage(),
      const FacilitiesPage(),
      const NotesPage(),
      const ProfilePage(),
    ];
    return Consumer<NavigationProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: pages[value.currentPosition],
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: kPrimaryColor1,
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
                    label: "Staffs",
                    icon: Icon(
                      Iconsax.people,
                    )),
                BottomNavigationBarItem(
                    label: "Facilities",
                    icon: Icon(
                      Iconsax.category,
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
