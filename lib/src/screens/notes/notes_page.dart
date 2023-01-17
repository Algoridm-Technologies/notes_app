import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/screens/notes/components/note_header_tile.dart';
import 'package:note/src/screens/notes/components/notes_list.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/horizontal_gap.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
    );
  }
}
