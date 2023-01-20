import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/provider/util/tab_provider.dart';
import 'package:note/src/screens/employee_screens/employee_notes/components/note_tab_tile.dart';
import 'package:note/src/screens/employee_screens/employee_notes/components/other_notes_list.dart';

import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:provider/provider.dart';

import 'components/note_header_tile.dart';
import 'components/your_notes_list.dart';

class EmployeeNotesPage extends StatelessWidget {
  const EmployeeNotesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckProvider>(builder: (context, v, c) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: screenPadding,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.more,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  const Icon(Iconsax.note_favorite),
                  const HorizontalGap(gap: 20),
                  Text(
                    'Work  Notes',
                    style: heading3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: const NoteHeaderTile(),
            ),
            Padding(
              padding: screenPadding,
              child: const NoteTabTile(),
            ),
            Expanded(
              child: Consumer<TabProvider>(builder: (context, v, c) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: screenPadding,
                  children: [
                    v.tab == 0 ? const YourNotesList() : const OtherNotesList(),
                  ],
                );
              }),
            ),
          ],
        ),
        bottomSheet: v.isChecking
            ? SizedBox(
                height: 80,
                width: double.infinity,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<CheckProvider>(context, listen: false)
                            .changeIsChecking(false);
                      },
                      icon: const Icon(
                        Iconsax.trash,
                      ),
                    ),
                    const Text("Delete")
                  ],
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
