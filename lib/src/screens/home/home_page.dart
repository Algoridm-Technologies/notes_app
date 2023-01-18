import 'package:flutter/material.dart';
import 'package:note/src/screens/home/components/notes_list.dart';
import 'package:note/src/screens/home/components/tab_tile.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/vertical_gap.dart';

import 'components/header_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: false,
        body: ListView(
          padding: screenPadding,
          physics: const BouncingScrollPhysics(),
          children: [
            const VerticalGap(gap: 30),
            const HeaderTile(),
            const VerticalGap(gap: 10),
            const TabTile(),
            const VerticalGap(gap: 10),
            Text(
              "Recent Notes On Nazasmart Facility",
              style: layer1,
            ),
            const VerticalGap(gap: 10),
            const NotesList(),
            const VerticalGap(gap: 20),
          ],
        ));
  }
}
