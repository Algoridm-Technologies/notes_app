import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/provider/util/search_provider.dart';
import 'package:note/src/screens/employer_screens/notes_details/notes_details_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:note/src/widget/notes_note_tile.dart';
import 'package:provider/provider.dart';

import '../../../../provider/database/note_detail_employer_provider.dart';
import '../../../../provider/util/setstate_provider.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await RefreshToken.refreshToken().then((value) {
          Provider.of<EmployeeAndNoteProvider>(context, listen: false)
              .getFacility();
        });
      },
      child: Consumer<SearchProvider>(
        builder: (context, search, child) {
          return Consumer<CheckProvider>(builder: (context, v, c) {
            return Consumer<EmployeeAndNoteProvider>(
              builder: (context, value, child) {
                return value.isLoading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: const Center(child: CircularProgressIndicator()))
                    : value.list.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: const Center(child: Text("No item")))
                        : ListView.builder(
                            itemCount: value.list.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: ((context, index) {
                              var data = value.list[index]!;
                              return NotesNoteTile(
                                isUser: false,
                                index: index,
                                note: value.list[index]!,
                                onTap: () {
                                  Provider.of<NoteDetailEmployerProvider>(
                                          context,
                                          listen: false)
                                      .getFacility(data.id!);
                                  Provider.of<SetStateProvider>(context,
                                          listen: false)
                                      .changeState(false);
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
        },
      ),
    );
  }
}
