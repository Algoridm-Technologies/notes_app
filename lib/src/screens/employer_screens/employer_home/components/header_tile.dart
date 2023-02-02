import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:note/src/provider/database/access_provider.dart';
import 'package:note/src/screens/notification/notification_page.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.r,
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<AccessProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.isLoggedIn
                        ? value.model!.fullName ?? ""
                        : "Loading...",
                    style: heading2,
                  );
                },
              ),
              Text(
                "Good day",
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
  }
}
