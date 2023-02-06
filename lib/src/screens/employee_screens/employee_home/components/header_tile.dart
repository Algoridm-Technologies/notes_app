import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../provider/database/profile_detail_provider.dart';
import '../../../../utils/constants.dart';
import '../../../notification/notification_page.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileDetailProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              value.isLoggedIn
                  ? CircleAvatar(
                      radius: 30.r,
                      backgroundImage: NetworkImage(value.model!.avatar ?? ""),
                    )
                  : CircleAvatar(
                      radius: 30.r,
                    ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.isLoggedIn
                        ? value.model!.fullName ?? ""
                        : "Not loggedin",
                    style: heading2,
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
      },
    );
  }
}
