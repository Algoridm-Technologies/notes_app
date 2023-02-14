import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note/src/api/select_facility_api.dart';
import 'package:note/src/model/facility_model.dart';
import 'package:note/src/provider/database/current_facility_provider.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/database/facility_provider.dart';
import 'package:note/src/screens/add_facility/add_facility_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:note/src/widget/custom_snackbar.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/processing_dialogue.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

class EmployerFacilitiesPage extends StatefulWidget {
  const EmployerFacilitiesPage({Key? key}) : super(key: key);

  @override
  State<EmployerFacilitiesPage> createState() => _EmployerFacilitiesPageState();
}

class _EmployerFacilitiesPageState extends State<EmployerFacilitiesPage> {
  // List<Facilities?> list = [];

  @override
  Widget build(BuildContext context) {
    // list.clear();
    // ListAllNotesApi.listEmployees();
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            const VerticalGap(gap: 50),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await RefreshToken.refreshToken().then((value) {
                    Provider.of<FacilityProvider>(context, listen: false)
                        .getFacility();
                  });
                },
                child: Consumer<FacilityProvider>(
                  builder: (context, model, child) {
                    var newList = model.list;
                    // if (!list.contains(const Facilities(
                    //     id: "0",
                    //     title: "All",
                    //     location: "All",
                    //     image: "All"))) {
                    //   list.add(const Facilities(
                    //       id: "0",
                    //       title: "All",
                    //       location: "All",
                    //       image: "All"));
                    // }

                    // List<Facilities?> newList = model.list
                    //   ..sort(
                    //     (a, b) => a!.id!
                    //         .toLowerCase()
                    //         .compareTo(b!.id!.toLowerCase()),
                    //   );
                    return model.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : newList.isEmpty
                            ? const Center(child: Text("No item"))
                            : LayoutBuilder(builder: (context, value) {
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1 / 2 / 0.6,
                                    crossAxisSpacing: 12,
                                  ),
                                  itemCount: newList.length,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = newList[index]!;
                                    return GestureDetector(
                                      onTap: () {
                                        selectFacility(data.id!, data.title!);
                                      },
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image:
                                                      NetworkImage(data.image!),
                                                  fit: BoxFit.cover,
                                                  onError:
                                                      (exception, stackTrace) =>
                                                          Container(
                                                    color: kGreyColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(data.title!),
                                            Text(data.location!),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              });
                  },
                ),
              ),
            ),
            DefaultButton(
              widget: Text(
                "Add Facility",
                style: heading3White,
              ),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: kAnimationDuration,
                    pageBuilder: ((context, animation, _) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AddFacilityPage(),
                      );
                    }),
                  ),
                );
              },
            ),
            const VerticalGap(gap: 50),
          ],
        ),
      ),
    );
  }

  selectFacility(String id, String name) async {
    ProcessingDialog.showProcessingDialog(
        context: context,
        title: "Changing Facility",
        subtitle: "Changing to $name ");

    if (id == "0") {
      await RefreshToken.refreshToken().then((value) {
        ProcessingDialog.cancelDialog(context);

        CustomSnackBar.showSnackbar(
            context: context, title: "All Facility Selected");

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
          ProcessingDialog.cancelDialog(context);

          if (jsonDecode(value)["success"] != null) {
            CustomSnackBar.showSnackbar(
                context: context, title: jsonDecode(value)["success"]);
          }
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
