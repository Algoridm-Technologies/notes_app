import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/horizontal_gap.dart';

import '../../employee_add_notes/employee_add_notes_page.dart';

class TabTile extends StatelessWidget {
  const TabTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Material(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Ink(
            height: 200.h,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: kPrimaryGradientColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ",
                        style: heading3White,
                      ),
                      Text(
                        "Take note of your Daily Activities At Work",
                        style: heading3White,
                      ),
                      SizedBox(
                        width: 200.w,
                        child: DefaultButton(
                            color: kWhiteColor,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Take note",
                                  style: TextStyle(color: kPrimaryColor1),
                                ),
                                HorizontalGap(gap: 10),
                                Icon(
                                  Icons.edit,
                                  color: kPrimaryColor1,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: kAnimationDuration,
                                  pageBuilder: ((context, animation, _) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: const EmployeeAddNotesPage(),
                                    );
                                  }),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/office.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
