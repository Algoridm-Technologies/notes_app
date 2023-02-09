import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/database/note_by_employee_provider.dart';
import 'package:note/src/screens/staffs_note/staffs_note.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

class StaffsList extends StatelessWidget {
  const StaffsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          var prefs = await SharedPreferences.getInstance();
          var name = prefs.getString('facilityId');
          if (name == "0") {
            await RefreshToken.refreshToken().then((value) {
              Provider.of<EmployeeAndNoteProvider>(context, listen: false)
                  .getEmployee();
            });
          } else {
            await RefreshToken.refreshToken().then((value) {
              Provider.of<EmployeeAndNoteProvider>(context, listen: false)
                  .getFacility();
            });
          }
        },
        child: Consumer<EmployeeAndNoteProvider>(
          builder: (context, value, child) {
            return value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : value.list.isEmpty
                    ? const Center(child: Text("No item"))
                    : ListView.builder(
                        itemCount: value.em.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = value.em[index]!;
                          return Column(
                            children: [
                              ListTile(
                                leading: data.avatar == null
                                    ? CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            kPrimaryColor1.withOpacity(0.2),
                                        child: Text(
                                            data.fullName![0].toUpperCase()),
                                      )
                                    : CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(data.avatar ?? ""),
                                      ),
                                title: Text("${data.fullName}"),
                                onTap: () {
                                  Provider.of<NoteByEmployeeProvider>(context,
                                          listen: false)
                                      .getFacility(employeeId: data.id!);
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: kAnimationDuration,
                                      pageBuilder: ((context, animation, _) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: StaffsNotePage(
                                            name: data.fullName ?? "",
                                            image: data.avatar ?? "",
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                              const VerticalGap(gap: 10),
                            ],
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
