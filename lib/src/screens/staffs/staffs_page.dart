import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/screens/add_staff/add_staffs_page.dart';
import 'package:note/src/screens/staffs/components/staff_list.dart';
import 'package:note/src/utils/constants.dart';

import '../../widget/vertical_gap.dart';

class EmployerStaffsPage extends StatelessWidget {
  const EmployerStaffsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const VerticalGap(gap: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: screenPadding,
              child: Text(
                "Nazasmart Facility",
                style: heading3,
              ),
            ),
          ),
          const VerticalGap(gap: 20),
          const StaffsList(),
        ],
      ),
      floatingActionButton: CircleAvatar(
        radius: 30.r,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: kAnimationDuration,
                pageBuilder: ((context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const AddStaffsPage(),
                  );
                }),
              ),
            );
          },
          icon: const Center(
            child: Icon(
              Icons.add_rounded,
              size: 30,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
   
    );
  }
}
