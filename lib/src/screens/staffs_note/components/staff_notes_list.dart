import 'package:flutter/material.dart';
import 'package:note/src/provider/database/note_detail_employer_provider.dart';
import 'package:note/src/screens/employer_screens/notes_details/notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/employee_notes_tile.dart';
import 'package:provider/provider.dart';

import '../../../provider/database/note_by_employee_provider.dart';

class StaffsNotesList extends StatelessWidget {
  const StaffsNotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteByEmployeeProvider>(
      builder: (context, value, child) {
        return ListView.builder(
            itemCount: value.myList.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              return EmployeeNotesTile(
                isUser: false,
                index: index,
                note: value.myList[index]!,
                onTap: () {
                  Provider.of<NoteDetailEmployerProvider>(context,
                          listen: false)
                      .getFacility(value.myList[index]!.id!);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: kAnimationDuration,
                      pageBuilder: ((context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: const NotesDetailPage(),
                        );
                      }),
                    ),
                  );
                },
              );
            }));
      },
    );
  }
}
