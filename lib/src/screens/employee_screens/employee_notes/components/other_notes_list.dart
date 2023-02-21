import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_note_provider.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/screens/employee_screens/employee_notes_details/employee_notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/other_notes_tile.dart';
import 'package:provider/provider.dart';

import '../../../../provider/util/setstate_provider.dart';
import '../../../../utils/refresh_token.dart';

class OtherNotesList extends StatelessWidget {
  const OtherNotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await RefreshToken.refreshToken().then((value) {
          Provider.of<EmployeeNoteProvider>(context, listen: false)
              .getNotesAndEmployee();
        });
      },
      child: Consumer<EmployeeNoteProvider>(builder: (context, value, child) {
        return value.isLoading
            ? const Center(child: CircularProgressIndicator())
            : value.em.isEmpty
                ? const Center(child: Text("No note"))
                : ListView.builder(
                    itemCount: value.em.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return OtherNotesTile(
                        isUser: false,
                        index: index,
                        note: value.em[index]!,
                        onTap: () {
                          Provider.of<SetStateProvider>(context, listen: false)
                              .changeState(true);
                          Provider.of<NoteDetailEmployeeProvider>(context,
                                  listen: false)
                              .getNoteDetails(value.em[index]!.id!);
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: kAnimationDuration,
                              pageBuilder: ((context, animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: EmployeeNotesDetailPage(
                                    isUser: true,
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      );
                    }));
      }),
    );
  }
}
