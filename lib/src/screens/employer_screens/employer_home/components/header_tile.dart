import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note/src/provider/database/profile_detail_provider.dart';
import 'package:note/src/screens/notification/notification_page.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;
    var greeting = "Good Morning";
    if (currentHour < 12) {
      greeting = "Good Morning";
    } else if (currentHour < 18) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }

    return Consumer<ProfileDetailProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !value.isLoggedIn
                  ? CircleAvatar(
                      radius: 30.r,
                      backgroundColor: kPrimaryColor1.withOpacity(0.5),
                      child: const CupertinoActivityIndicator(),
                    )
                  : value.model!.avatar == null
                      ? CircleAvatar(
                          radius: 30.r,
                          backgroundColor: kPrimaryColor1.withOpacity(0.5),
                          child: Center(
                            child: Text(
                              value.model!.fullName![0],
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 30.r,
                          onBackgroundImageError: (exception, stackTrace) {
                            return log("cannot load");
                          },
                          backgroundImage:
                              NetworkImage(value.model!.avatar ?? ""),
                        ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.isLoggedIn
                        ? value.model!.fullName ?? ""
                        : "",
                    style: heading2,
                  ),
                  Text(
                    greeting,
                    style: heading3,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: kAnimationDuration,
                      pageBuilder: ((context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: const NotificationPage(),
                        );
                      }),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/icons/notification.svg',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
