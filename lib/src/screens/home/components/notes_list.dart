import 'package:flutter/material.dart';
import 'package:note/src/widget/notes_tile.dart';

import '../../../utils/constants.dart';
import '../../notes_details/notes_details_page.dart';

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
