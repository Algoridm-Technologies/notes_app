import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/database/current_facility_provider.dart';
import 'package:note/src/screens/staffs_note/components/staff_note_header_tile.dart';
import 'package:note/src/screens/staffs_note/components/staff_notes_list.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:provider/provider.dart';

import '../../widget/horizontal_gap.dart';

class StaffsNotePage extends StatelessWidget {
  final String name;
  final String image;
  const StaffsNotePage({Key? key, required this.name, required this.image}) : super(key: key);
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
                Consumer<CurrentFacilityProvider>(
                  builder: (context, value, child) {
                    return Text(
                      !value.isLoggedIn
                          ? "No Facility"
                          : value.model!.facilityName ?? "",
                      style: heading3,
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: screenPadding,
            child:  StaffNoteHeaderTile(
              name: name,
              image: image,
            ),
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
