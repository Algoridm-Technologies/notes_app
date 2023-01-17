import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/screens/staffs_note/components/staff_note_header_tile.dart';
import 'package:note/src/screens/staffs_note/components/staff_notes_list.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_back_button.dart';

import '../../widget/horizontal_gap.dart';

class StaffsNotePage extends StatelessWidget {
  const StaffsNotePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
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
            child: const StaffNoteHeaderTile(),
          ),
          Expanded(
              child: Padding(
            padding: screenPadding,
            child: const StaffsNotesList(),
          )),
        ],
      ),
    );
  }
}
