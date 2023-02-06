import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_note_provider.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/screens/employee_screens/employee_notes_details/employee_notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/other_notes_tile.dart';
import 'package:provider/provider.dart';

class OtherNotesList extends StatelessWidget {
  const OtherNotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeNoteProvider>(
      builder: (context, value, child) {
        return Consumer<CheckProvider>(builder: (context, v, c) {
          return ListView.builder(
              itemCount: value.em.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                return OtherNotesTile(
                  isUser: false,
                  index: index,
                  note: value.em[index]!,
                  onTap: () {
                    Provider.of<NoteDetailEmployeeProvider>(context,
                            listen: false)
                        .getFacility(value.em[index]!.id!);
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
