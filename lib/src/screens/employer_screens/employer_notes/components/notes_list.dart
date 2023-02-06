import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/screens/employer_screens/notes_details/notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/notes_tile.dart';
import 'package:provider/provider.dart';

import '../../../../provider/database/note_detail_employer_provider.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckProvider>(builder: (context, v, c) {
      return Consumer<EmployeeAndNoteProvider>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: value.list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                var data = value.list[index]!;
                return NotesTile(
                  isUser: false,
                  index: index,
                  note: value.list[index]!,
                  onTap: () {
                    Provider.of<NoteDetailEmployerProvider>(context,
                            listen: false)
                        .getFacility(data.id!);
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
    });
  }
}
