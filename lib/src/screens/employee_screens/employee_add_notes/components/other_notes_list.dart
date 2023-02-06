import 'package:flutter/material.dart';
import 'package:note/src/model/employee_and_note_model.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/screens/employer_screens/notes_details/notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/notes_tile.dart';
import 'package:provider/provider.dart';

class OtherNotesList extends StatelessWidget {
  const OtherNotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckProvider>(builder: (context, v, c) {
      return ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return NotesTile(
              isUser: false,
              index: index,
              note: Notes(),
              onTap: () {
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
    });
  }
}
