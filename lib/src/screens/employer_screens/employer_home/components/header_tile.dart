import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:note/src/screens/notification/notification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants.dart';

class HeaderTile extends StatefulWidget {
  const HeaderTile({Key? key}) : super(key: key);

  @override
  State<HeaderTile> createState() => _HeaderTileState();
}

class _HeaderTileState extends State<HeaderTile> {
  String name = "";
  @override
  void initState() {
    super.initState();
    fetchName();
  }

  fetchName() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token") ?? "";
    Map<String, dynamic> data = Jwt.parseJwt(token);
    
    name = data["full_name"];
    setState(() {});
  }

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
                name,
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
  }
}
