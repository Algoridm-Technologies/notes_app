import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/screens/employee_screens/employee_add_notes/employee_add_notes_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/vertical_gap.dart';

import 'components/header_tile.dart';
import 'components/notes_list.dart';
import 'components/tab_tile.dart';

class EmployeeHomePage extends StatelessWidget {
  const EmployeeHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: false,
        body: ListView(
          padding: screenPadding,
          physics: const BouncingScrollPhysics(),
          children: [
            const VerticalGap(gap: 30),
            const HeaderTile(),
            const VerticalGap(gap: 10),
            const TabTile(),
            const VerticalGap(gap: 10),
            Text(
              "Recent Notes ",
              style: layer1,
            ),
            const VerticalGap(gap: 10),
            const NotesList(),
            const VerticalGap(gap: 20),
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
                      child: const EmployeeAddNotesPage(),
                    );
                  }),
                ),
              );
            },
            icon: const Center(
              child: Icon(
                Icons.edit_outlined,
                size: 30,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
