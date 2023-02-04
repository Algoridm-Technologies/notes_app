import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/src/api/employee_and_note_api.dart';
import 'package:note/src/api/select_facility_api.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            const VerticalGap(gap: 50),
            Expanded(
              child: Consumer<FacilityProvider>(
                builder: (context, model, child) {
                  return model.isLoading
                      ? const CupertinoActivityIndicator()
                      : LayoutBuilder(builder: (context, value) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1 / 2 / 0.6,
                              crossAxisSpacing: 12,
                            ),
                            itemCount: model.list.length,
                            itemBuilder: (context, index) {
                              var data = model.list[index]!;
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
                                          image: DecorationImage(
                                            image: NetworkImage(data.image!),
                                            onError: (exception, stackTrace) =>
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
    await RefreshToken.refreshToken();
    await SelectFacilityApi.selectFacility(id: id).then((value) {
      ProcessingDialog.cancelDialog(context);
      if (jsonDecode(value)["success"] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)["success"]);
      }

      print(value);
    });
    await EmployeeAndNoteApi.currentEmployeeAndFacility().then((value) {
      print(value);
    });
  }
}
