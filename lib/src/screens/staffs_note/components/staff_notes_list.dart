import 'package:flutter/material.dart';
import 'package:note/src/screens/notes_details/notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/notes_tile.dart';

class StaffsNotesList extends StatelessWidget {
  const StaffsNotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
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
                      child: const NotesDetailPage(),
                    );
                  }),
                ),
              );
            },
          );
        }));
  }
}
