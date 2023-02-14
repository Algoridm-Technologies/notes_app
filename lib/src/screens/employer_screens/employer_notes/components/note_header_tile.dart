import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../api/select_facility_api.dart';
import '../../../../model/facility_model.dart';
import '../../../../provider/database/current_facility_provider.dart';
import '../../../../provider/database/employee_and_note_provider.dart';
import '../../../../provider/database/facility_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/refresh_token.dart';
import '../../../../widget/horizontal_gap.dart';

class NoteHeaderTile extends StatelessWidget {
  const NoteHeaderTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var selected = const Facilities(
        id: "0", title: "All Staff", location: "All", image: "All");
    List<Facilities?> list = [];
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
              Align(
                alignment: Alignment.topLeft,
                child: Consumer<FacilityProvider>(
                  builder: (context, value, child) {
                    return Consumer<CurrentFacilityProvider>(
                      builder: (context, va, child) {
                        list = value.list;
                        if (!list.contains(const Facilities(
                            id: "0",
                            title: "All Staff",
                            location: "All",
                            image: "All"))) {
                          list.add(const Facilities(
                              id: "0",
                              title: "All Staff",
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
                              print(v!.id);
                              selectFacility(v.id!, v.title!, context);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.search_normal,
            ),
          ),
        ],
      ),
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
        Provider.of<EmployeeAndNoteProvider>(context, listen: false)
            .getEmployee();
        Provider.of<EmployeeAndNoteProvider>(context, listen: false).getNote();
        Provider.of<CurrentFacilityProvider>(context, listen: false)
            .setAccess(facilityName: name, facilityId: id);
        Provider.of<CurrentFacilityProvider>(context, listen: false)
            .getAccess();
      });
    } else {
      await RefreshToken.refreshToken().then((value) {
        SelectFacilityApi.selectFacility(id: id).then((value) async {
          Provider.of<CurrentFacilityProvider>(context, listen: false)
              .setAccess(facilityName: name, facilityId: id);

          Provider.of<CurrentFacilityProvider>(context, listen: false)
              .getAccess();

          Provider.of<EmployeeAndNoteProvider>(context, listen: false)
              .getFacility();
        });
      });
    }
  }
}
