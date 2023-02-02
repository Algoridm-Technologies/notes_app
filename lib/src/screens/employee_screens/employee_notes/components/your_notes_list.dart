import 'package:flutter/material.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/screens/employee_screens/employee_notes_details/employee_notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/notes_tile.dart';
import 'package:provider/provider.dart';

class YourNotesList extends StatelessWidget {
  const YourNotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckProvider>(builder: (context, v, c) {
      return ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return NotesTile(
              isUser: true,
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
    });
  }
}
