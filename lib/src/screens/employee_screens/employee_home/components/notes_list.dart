import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_note_provider.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/screens/employee_screens/employee_notes_details/employee_notes_details_page.dart';
import 'package:provider/provider.dart';

import '../../../../provider/util/setstate_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../widget/my_notes_tile.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeNoteProvider>(
      builder: (context, value, child) {
        return value.isLoading
            ? const Center(child: Hero(
              tag: "progress",
              child: CircularProgressIndicator()))
            : value.myList.isEmpty
                ? const Center(child: Text("No note"))
                : ListView.builder(
                    itemCount: value.myList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return MyNotesTile(
                        isUser: false,
                        index: index,
                        note: value.myList[index]!,
                        onTap: () {
                          Provider.of<SetStateProvider>(context, listen: false)
                              .changeState(true);
                          Provider.of<NoteDetailEmployeeProvider>(context,
                                  listen: false)
                              .getNoteDetails(value.myList[index]!.id!);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: kAnimationDuration,
                              pageBuilder: ((context, animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: const EmployeeNotesDetailPage(
                                    isUser: false,
                                  ),
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
