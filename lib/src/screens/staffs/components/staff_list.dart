import 'package:flutter/material.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/database/note_by_employee_provider.dart';
import 'package:note/src/screens/staffs_note/staffs_note.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';

class StaffsList extends StatelessWidget {
  const StaffsList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<EmployeeAndNoteProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.em.length,
          itemBuilder: (context, index) {
            var data = value.em[index]!;
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(data.avatar ?? ""),
                  ),
                  title: Text("${data.fullName}"),
                  onTap: () {
                    Provider.of<NoteByEmployeeProvider>(context, listen: false)
                        .getFacility(employeeId: data.id!);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: kAnimationDuration,
                        pageBuilder: ((context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: const StaffsNotePage(),
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
    ));
  }
}
