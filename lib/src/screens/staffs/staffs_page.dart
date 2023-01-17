import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/screens/staffs/components/staff_list.dart';
import 'package:note/src/utils/constants.dart';

import '../../widget/vertical_gap.dart';

class StaffsPage extends StatelessWidget {
  const StaffsPage({Key? key}) : super(key: key);
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
        radius: 40.r,
        child: IconButton(
          onPressed: () {},
          icon: const Center(
            child: Icon(
              Icons.add_rounded,
              size: 50,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
