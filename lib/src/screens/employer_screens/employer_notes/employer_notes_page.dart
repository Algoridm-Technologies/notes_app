import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/delect_note_api.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:provider/provider.dart';

import 'components/note_header_tile.dart';
import 'components/notes_list.dart';

class EmployerNotesPage extends StatelessWidget {
  const EmployerNotesPage({Key? key}) : super(key: key);
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
                    'Nazasmart Facility',
                    style: heading3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: const NoteHeaderTile(),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: screenPadding,
                children: const [
                  NotesList(),
                ],
              ),
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
                        var list = v.positions;
                        DeleteNoteApi.deleteNote(id: list).then((value) {
                          print(value);
                        });
                        // Provider.of<CheckProvider>(context, listen: false)
                        //     .changeIsChecking(false);
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
