import 'package:flutter/material.dart';
import 'package:note/src/screens/staffs_note/staffs_note.dart';
import 'package:note/src/widget/vertical_gap.dart';

import '../../../utils/constants.dart';

class StaffsList extends StatelessWidget {
  const StaffsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 30,
              ),
              title: const Text("Koln Mark"),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: kAnimationDuration,
                    pageBuilder: ((context, animation, _) {
                      return FadeTransition(
                        opacity: animation,
                        child: const StaffsNotePage(),
                      );
                    }),
                  ),
                );
              },
            ),
            const VerticalGap(gap: 10),
          ],
        );
      },
    ));
  }
}
