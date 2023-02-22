import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/model/employee_note_model.dart';
import 'package:note/src/provider/util/tab_provider.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

import '../../../../provider/database/employee_note_provider.dart';
import '../../../../provider/database/note_detail_employee_provider.dart';
import '../../../../provider/util/setstate_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../widget/my_notes_tile.dart';
import '../../../../widget/other_notes_tile.dart';
import '../../employee_notes_details/employee_notes_details_page.dart';

class NoteHeaderTile extends StatelessWidget {
  const NoteHeaderTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All Notes",
                style: heading1,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              var v = Provider.of<TabProvider>(context, listen: false).tab;

              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      user: v,
                      team: Provider.of<EmployeeNoteProvider>(context,
                              listen: false)
                          .em,
                      mine: Provider.of<EmployeeNoteProvider>(context,
                              listen: false)
                          .myList));
            },
            icon: const Icon(
              Iconsax.search_normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchItem = [
    'Note',
    'Monday',
    'testing',
    'set',
  ];
  final int user;
  final List<TeamMatesNotes?> team;
  final List<MyNotes?> mine;

  CustomSearchDelegate({
    required this.user,
    required this.team,
    required this.mine,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Iconsax.arrow_left_2),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<TeamMatesNotes?> teamMatchQuery = [];
    for (var note in team) {
      if (note!.title!.toLowerCase().contains(query.toLowerCase()) ||
          note.text!.toLowerCase().contains(query.toLowerCase()) ||
          note.user!.fullName!.toLowerCase().contains(query.toLowerCase())) {
        teamMatchQuery.add(note);
      }
    }
    List<MyNotes?> mineMatchQuery = [];
    for (var note in mine) {
      if (note!.title!.toLowerCase().contains(query.toLowerCase()) ||
          note.text!.toLowerCase().contains(query.toLowerCase())) {
        mineMatchQuery.add(note);
      }
    }
    if (user == 0 ? mineMatchQuery.isEmpty : teamMatchQuery.isEmpty) {
      return const Center(child: Text("No Search found"));
    }

    return ListView.separated(
        padding: screenPadding,
        itemBuilder: (context, index) {
          return user == 0
              ? MyNotesTile(
                  isUser: true,
                  index: index,
                  note: mineMatchQuery[index]!,
                  onTap: () {
                    Provider.of<SetStateProvider>(context, listen: false)
                        .changeState(true);
                    Provider.of<NoteDetailEmployeeProvider>(context,
                            listen: false)
                        .getNoteDetails(mineMatchQuery[index]!.id!);
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
                )
              : OtherNotesTile(
                  isUser: false,
                  index: index,
                  note: teamMatchQuery[index]!,
                  onTap: () {
                    Provider.of<SetStateProvider>(context, listen: false)
                        .changeState(true);
                    Provider.of<NoteDetailEmployeeProvider>(context,
                            listen: false)
                        .getNoteDetails(teamMatchQuery[index]!.id!);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: kAnimationDuration,
                        pageBuilder: ((context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: const EmployeeNotesDetailPage(
                              isUser: true,
                            ),
                          );
                        }),
                      ),
                    );
                  },
                );
        },
        separatorBuilder: (context, index) {
          return const VerticalGap(gap: 10);
        },
        itemCount: user == 0 ? mineMatchQuery.length : teamMatchQuery.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<TeamMatesNotes?> teamMatchQuery = [];
    for (var fruit in team) {
      if (fruit!.title!.toLowerCase().contains(query.toLowerCase())) {
        teamMatchQuery.add(fruit);
      }
    }
    List<MyNotes?> mineMatchQuery = [];
    for (var fruit in mine) {
      if (fruit!.title!.toLowerCase().contains(query.toLowerCase())) {
        mineMatchQuery.add(fruit);
      }
    }

    return const Text('');
  }
}
