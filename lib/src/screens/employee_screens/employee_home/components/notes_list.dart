import 'package:flutter/material.dart';
import 'package:note/src/screens/employee_screens/employee_notes_details/employee_notes_details_page.dart';
import 'package:note/src/widget/notes_tile.dart';

import '../../../../utils/constants.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return NotesTile(
            isUser: false,
            index: index,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: kAnimationDuration,
                  pageBuilder: ((context, animation, _) {
                    return FadeTransition(
                      opacity: animation,
                      child: const EmployeeNotesDetailPage(),
                    );
                  }),
                ),
              );
            },
          );
        }));
  }
}
