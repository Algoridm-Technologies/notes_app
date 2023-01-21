import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/navigation/employee_navigation_provider.dart';
import 'package:note/src/screens/edit_profile/edit_profile_page.dart';
import 'package:note/src/screens/launch/launch_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: heading3White,
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 350.h,
            child: Stack(
              children: [
                Container(
                  height: 270.h,
                  color: kGreyColor,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: 130.h,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.r,
                        ),
                        const Text('Colin Mark'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: kAnimationDuration,
                              pageBuilder: ((context, animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: const EditProfilePage(),
                                );
                              }),
                            ),
                          );
                        },
                        title: const Text(
                          "Personal Information",
                        ),
                        trailing: const Icon(
                          Iconsax.arrow_right_3,
                        ),
                        leading: const Icon(
                          Iconsax.user,
                        ),
                        subtitle: const Text(
                          "Manage your informations Details names, Email, Etc.",
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        title: const Text(
                          "Security",
                        ),
                        trailing: const Icon(
                          Iconsax.arrow_right_3,
                        ),
                        leading: const Icon(
                          Iconsax.user,
                        ),
                        subtitle: const Text(
                          "Manage your informations Details names, Email, Etc.",
                        ),
                      ),
                      const VerticalGap(gap: 50),
                      Hero(
                        tag: "button",
                        child: DefaultButton(
                            color: kSecondaryColor,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Log out",
                                  style: heading3White,
                                ),
                                const HorizontalGap(gap: 5),
                                const Icon(
                                  Iconsax.logout_1,
                                  color: kWhiteColor,
                                )
                              ],
                            ),
                            onTap: () {
                              Provider.of<EmployeeNavigationProvider>(context,
                                      listen: false)
                                  .changePage(0);
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: kAnimationDuration,
                                  pageBuilder: ((context, animation, _) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: const LaunchPage(),
                                    );
                                  }),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
