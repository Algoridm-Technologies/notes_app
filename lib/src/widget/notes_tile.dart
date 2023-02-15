import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:note/src/model/employee_and_note_model.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/vertical_gap.dart';

import '../utils/constants.dart';

class NotesTile extends StatelessWidget {
  final bool isUser;
  final VoidCallback onTap;
  final int index;
  final Notes note;
  const NotesTile({
    Key? key,
    required this.isUser,
    required this.onTap,
    required this.index,
    required this.note,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                // onLongPress: () {
                //   v.positions.clear();
                //   if (v.isChecking) {
                //     v.changeIsChecking(false);
                //   } else {
                //     v.changeIsChecking(true);
                //   }
                // },
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
                              isUser
                                  ? const SizedBox()
                                  : note.user!.avatar == null
                                      ? CircleAvatar(
                                          radius: 15.sp,
                                          backgroundColor:
                                              kPrimaryColor1.withOpacity(0.2),
                                          child: Text(note.user!.fullName![0]
                                              .toUpperCase()),
                                        )
                                      : CircleAvatar(
                                          radius: 15.sp,
                                          backgroundImage:
                                              NetworkImage(note.user!.avatar!),
                                        ),
                              isUser
                                  ? const SizedBox()
                                  : const HorizontalGap(gap: 10),
                              isUser
                                  ? const SizedBox()
                                  : Text(
                                      "${note.user!.fullName}",
                                      style: subTitle,
                                    ),
                              isUser
                                  ? const SizedBox()
                                  : const HorizontalGap(gap: 10),
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
          ],
        ),
      ),
    );
  }
}
