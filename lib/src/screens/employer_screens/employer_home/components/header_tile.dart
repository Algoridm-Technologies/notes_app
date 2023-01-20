import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/screens/notification/notification_page.dart';

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
              Text(
                "Koln Mark",
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
            icon: const Icon(
              Iconsax.notification4,
            ),
          ),
        ],
      ),
    );
  }
}
