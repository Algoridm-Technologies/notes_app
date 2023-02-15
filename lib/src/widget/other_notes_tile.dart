import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:note/src/model/employee_note_model.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class OtherNotesTile extends StatelessWidget {
  final bool isUser;
  final VoidCallback onTap;
  final int index;
  final TeamMatesNotes note;
  const OtherNotesTile({
    Key? key,
    required this.isUser,
    required this.onTap,
    required this.index,
    required this.note,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckProvider>(builder: (context, v, c) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        height: 150.sp,
        child: Material(
          child: Stack(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )),
                surfaceTintColor: kWhiteColor,
                color: kWhiteColor,
                child: InkWell(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        color: kAccentColor,
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5.sp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${note.title}",
                              style: layer1,
                            ),
                            const VerticalGap(gap: 2),
                            Expanded(
                              child: Text(
                                "${note.text}",
                                style: subTitle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                            const VerticalGap(gap: 5),
                            Row(
                              children: [
                                note.user!.avatar == null
                                    ? CircleAvatar(
                                        radius: 15.sp,
                                        backgroundColor:
                                            kPrimaryColor1.withOpacity(0.1),
                                        child: Text(note.user!.fullName![0]
                                            .toUpperCase()),
                                      )
                                    : CircleAvatar(
                                        radius: 15.sp,
                                        backgroundImage:
                                            NetworkImage(note.user!.avatar!),
                                      ),
                                const HorizontalGap(gap: 10),
                                note.user!.avatar == null
                                    ? const SizedBox()
                                    : Text(
                                        "${note.user!.fullName}",
                                        style: subTitle,
                                      ),
                                const HorizontalGap(gap: 10),
                                Text(
                                  DateFormat("EEEE, MMM d, yyyy")
                                      .format(DateTime.parse(note.updatedAt!)),
                                  style: subTitle,
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: v.isChecking
                    ? IconButton(
                        onPressed: () {
                          if (v.positions.contains(index.toString())) {
                            v.removeToList(index.toString());
                          } else {
                            v.addToList(index.toString());
                          }
                        },
                        icon: Icon(
                          Icons.check_box,
                          color: v.positions.contains(index.toString())
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
