import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/database/profile_detail_provider.dart';
import 'package:note/src/provider/navigation/employee_navigation_provider.dart';
import 'package:note/src/screens/edit_profile/edit_profile_page.dart';
import 'package:note/src/screens/launch/launch_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/logout_api.dart';

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
      body: Consumer<ProfileDetailProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                height: 350.h,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 350.h,
                      child: Stack(
                        children: [
                          value.isLoggedIn
                              ? value.model!.avatar == null
                                  ? Container(
                                      height: 300.h,
                                      color: kGreyColor,
                                    )
                                  : Container(
                                      height: 300.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              value.model!.avatar!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10.0, sigmaY: 10.0),
                                          child: Container(
                                            color: kWhiteColor.withOpacity(0.0),
                                          )),
                                    )
                              : Container(
                                  height: 300.h,
                                  color: kGreyColor,
                                ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: SizedBox(
                              height: 130.h,
                              child: Consumer<ProfileDetailProvider>(
                                builder: (context, value, child) {
                                  return Column(
                                    children: [
                                      value.isLoggedIn
                                          ? value.model!.avatar == null
                                              ? CircleAvatar(
                                                  radius: 50.r,
                                                  child: Text(value.isLoggedIn
                                                      ? value.model!.fullName
                                                          .toString()[0]
                                                      : ""),
                                                )
                                              : CircleAvatar(
                                                  radius: 50.r,
                                                  backgroundImage: NetworkImage(
                                                      value.model!.avatar!),
                                                )
                                          : CircleAvatar(
                                              radius: 50.r,
                                              child: const Center(
                                                  child:
                                                      CupertinoActivityIndicator()),
                                            ),
                                      Text(value.isLoggedIn
                                          ? value.model!.fullName ?? ""
                                          : ""),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
                          // ListTile(
                          //   onTap: () {},
                          //   title: const Text(
                          //     "Security",
                          //   ),
                          //   trailing: const Icon(
                          //     Iconsax.arrow_right_3,
                          //   ),
                          //   leading: const Icon(
                          //     Iconsax.user,
                          //   ),
                          //   subtitle: const Text(
                          //     "Manage your informations Details names, Email, Etc.",
                          //   ),
                          // ),
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
                                onTap: () async {
                                  var prefs =
                                      await SharedPreferences.getInstance();
                                  await LogoutApi.logout().then((value) {
                                    prefs.setString("token", "");
                                    Provider.of<EmployeeNavigationProvider>(
                                            context,
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
                                  });
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
