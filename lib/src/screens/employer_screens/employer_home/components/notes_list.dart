import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/database/note_detail_employer_provider.dart';
import 'package:note/src/widget/notes_tile.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../notes_details/notes_details_page.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeAndNoteProvider>(
      builder: (context, value, child) {
        return 
        
        value.list.isEmpty
            ? const Center(child: Text('No note'))
            : ListView.builder(
                itemCount: value.list.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  var data = value.list[index];
                  return NotesTile(
                    isUser: false,
                    note: data!,
                    index: index,
                    onTap: () async {
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
  }
}
