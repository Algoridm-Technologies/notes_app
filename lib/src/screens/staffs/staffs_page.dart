import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/model/facility_model.dart';
import 'package:note/src/provider/database/facility_provider.dart';
import 'package:note/src/screens/add_staff/add_staffs_page.dart';
import 'package:note/src/screens/staffs/components/staff_list.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../api/select_facility_api.dart';
import '../../provider/database/current_facility_provider.dart';
import '../../provider/database/employee_and_note_provider.dart';
import '../../utils/refresh_token.dart';
import '../../widget/vertical_gap.dart';

class EmployerStaffsPage extends StatelessWidget {
  const EmployerStaffsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Facilities?> list = [];
    return Scaffold(
      body: Column(
        children: [
          const VerticalGap(gap: 20),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: screenPadding,
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
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: kPrimaryColor1,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
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
          ),
          const VerticalGap(gap: 20),
          const StaffsList(),
        ],
      ),
      floatingActionButton: CircleAvatar(
        radius: 30.r,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: kAnimationDuration,
                pageBuilder: ((context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const AddStaffsPage(),
                  );
                }),
              ),
            );
          },
          icon: const Center(
            child: Icon(
              Icons.add_rounded,
              size: 30,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
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

  Widget buildFacilityItem(Facilities? e) {
    return Text(e!.title ?? "");
  }
}
