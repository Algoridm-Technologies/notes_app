import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/util/search_provider.dart';
import 'package:provider/provider.dart';

import '../../../../api/select_facility_api.dart';
import '../../../../model/employee_and_note_model.dart';
import '../../../../model/facility_model.dart';
import '../../../../provider/database/current_facility_provider.dart';
import '../../../../provider/database/employee_and_note_provider.dart';
import '../../../../provider/database/facility_provider.dart';
import '../../../../provider/database/note_detail_employer_provider.dart';
import '../../../../provider/util/setstate_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/refresh_token.dart';
import '../../../../widget/horizontal_gap.dart';
import '../../../../widget/notes_note_tile.dart';
import '../../../../widget/vertical_gap.dart';
import '../../notes_details/notes_details_page.dart';

class NoteHeaderTile extends StatelessWidget {
  const NoteHeaderTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var selected = const Facilities(
        id: "0", title: "All Facility", location: "All", image: "All");
    List<Facilities?> list = [];
    return Consumer<SearchProvider>(
      builder: (context, value, child) {
        return SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Consumer<FacilityProvider>(
                  builder: (context, value, child) {
                    return Consumer<CurrentFacilityProvider>(
                      builder: (context, va, child) {
                        list = value.list;
                        if (!list.contains(const Facilities(
                            id: "0",
                            title: "All Facility",
                            location: "All",
                            image: "All"))) {
                          list.add(const Facilities(
                              id: "0",
                              title: "All Facility",
                              location: "All",
                              image: "All"));
                        }
                        List<Facilities?> newList = list
                          ..sort(
                            (a, b) => a!.id!
                                .toLowerCase()
                                .compareTo(b!.id!.toLowerCase()),
                          );

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColor1,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: MediaQuery.of(context).size.width / 2,
                          child: DropdownButtonFormField(
                            iconSize: 15,
                            style: heading3White,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: kWhiteColor,
                            ),
                            dropdownColor: kPrimaryColor1,
                            decoration: const InputDecoration(
                              iconColor: kWhiteColor,
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            value: selected,
                            items: newList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: buildFacilityItem(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) async {
                              selectFacility(v!.id!, v.title!, context);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                          mine: Provider.of<EmployeeAndNoteProvider>(context,
                                  listen: false)
                              .list));
                },
                icon: const Icon(
                  Iconsax.search_normal,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildFacilityItem(Facilities? e) {
    return Row(
      children: [
        const Icon(
          Iconsax.note_favorite,
          color: kWhiteColor,
        ),
        const HorizontalGap(gap: 20),
        Text(e!.title ?? ""),
      ],
    );
  }

  selectFacility(String id, String name, BuildContext context) async {
    if (id == "0") {
      await RefreshToken.refreshToken().then((value) {
        Provider.of<EmployeeAndNoteProvider>(context, listen: false).getNote();
        Provider.of<CurrentFacilityProvider>(context, listen: false)
            .setAccess(facilityName: name, facilityId: "0");
        Provider.of<CurrentFacilityProvider>(context, listen: false)
            .getAccess();
      });
    } else {
      await RefreshToken.refreshToken().then((value) {
        SelectFacilityApi.selectFacility(id: id).then((value) async {
          print(value);
          Provider.of<CurrentFacilityProvider>(context, listen: false)
              .setAccess(facilityName: name, facilityId: id);

          Provider.of<CurrentFacilityProvider>(context, listen: false)
              .getAccess();

          Provider.of<EmployeeAndNoteProvider>(context, listen: false)
              .getNoteBy(facilityId: id);
        });
      });
    }
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchItem = [
    'Note',
    'Monday',
    'testing',
    'set',
  ];

  final List<Notes?> mine;

  CustomSearchDelegate({
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
    List<Notes?> mineMatchQuery = [];
    for (var notes in mine) {
      if (notes!.title!.toLowerCase().contains(query.toLowerCase()) ||
          notes.text!.toLowerCase().contains(query.toLowerCase()) ||
          notes.user!.fullName!.toLowerCase().contains(query.toLowerCase())) {
        mineMatchQuery.add(notes);
      }
    }
    if (mineMatchQuery.isEmpty) {
      return const Center(child: Text("No Search found"));
    }
    return ListView.separated(
        padding: screenPadding,
        itemBuilder: (context, index) {
          return Hero(
            tag: "$index",
            child: NotesNoteTile(
              isUser: false,
              index: index,
              note: mineMatchQuery[index]!,
              onTap: () {
                Provider.of<NoteDetailEmployerProvider>(context, listen: false)
                    .getFacility(mineMatchQuery[index]!.id!);
                Provider.of<SetStateProvider>(context, listen: false)
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
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const VerticalGap(gap: 10);
        },
        itemCount: mineMatchQuery.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Notes?> mineMatchQuery = [];
    for (var fruit in mine) {
      if (fruit!.title!.toLowerCase().contains(query.toLowerCase()) ||
          fruit.user!.fullName!.toLowerCase().contains(query.toLowerCase())) {
        mineMatchQuery.add(fruit);
      }
    }
    if (mineMatchQuery.isEmpty) {
      return const Center(child: Text("No Search found"));
    }

    return const Center(child: Text("type to start searching"));
  }
}
