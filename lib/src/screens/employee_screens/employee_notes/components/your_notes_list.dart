import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_note_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/screens/employee_screens/employee_notes_details/employee_notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/my_notes_tile.dart';
import 'package:provider/provider.dart';

import '../../../../provider/database/note_detail_employee_provider.dart';

class YourNotesList extends StatelessWidget {
  const YourNotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeNoteProvider>(
      builder: (context, value, child) {
        return Consumer<CheckProvider>(builder: (context, v, c) {
          return ListView.builder(
              itemCount: value.myList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                return MyNotesTile(
                  isUser: true,
                  index: index,
                  note: value.myList[index]!,
                  onTap: () {
                    Provider.of<NoteDetailEmployeeProvider>(context,
                            listen: false)
                        .getFacility(value.myList[index]!.id!);
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
      },
    );
  }
}
