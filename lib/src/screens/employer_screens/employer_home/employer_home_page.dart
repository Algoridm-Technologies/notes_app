import 'package:flutter/material.dart';

import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/vertical_gap.dart';

import 'components/header_tile.dart';
import 'components/notes_list.dart';
import 'components/tab_tile.dart';

class EmployerHomePage extends StatefulWidget {
  const EmployerHomePage({Key? key}) : super(key: key);

  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {

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
