import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/provider/database/profile_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../../../provider/util/setstate_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../widget/horizontal_gap.dart';

class HeaderTile extends StatelessWidget {
  final TextEditingController tileTextController;
  final bool isUser;
  const HeaderTile(
      {Key? key, required this.tileTextController, required this.isUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDetailEmployeeProvider>(
      builder: (context, value, child) {
        if (value.model != null) {
          if (tileTextController.text.isEmpty) {
            tileTextController.text = value.model!.title ?? "";
          }
        }
        return Column(
          children: [
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  const Icon(Iconsax.note_favorite),
                  const HorizontalGap(gap: 20),
                  Consumer<ProfileDetailProvider>(
                      builder: (context, value, child) {
                    return Text(
                      '${value.model!.facility} Facility',
                      style: heading3,
                    );
                  }),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: heading1,
                      readOnly: isUser,
                      controller: tileTextController,
                      decoration: InputDecoration(
                        hintText: "Title Goes Here",
                        hintStyle: heading1,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  // Text(
                  //   value.model == null ? "Loading" : value.model!.title ?? "",
                  //   style: heading1,
                  // ),
                  // const Spacer(),
                  IconButton(
                    onPressed: () {
                      // if (Provider.of<SetStateProvider>(context, listen: false)
                      //     .isReplying) {
                      //   Provider.of<SetStateProvider>(context, listen: false)
                      //       .changeState(false);
                      // } else {
                      //   Provider.of<SetStateProvider>(context, listen: false)
                      //       .changeState(true);
                      // }
                    },
                    icon: IconButton(
                      onPressed: () {
                        if (Provider.of<SetStateProvider>(context,
                                listen: false)
                            .isReplying) {
                          Provider.of<SetStateProvider>(context, listen: false)
                              .changeState(false);
                        } else {
                          Provider.of<SetStateProvider>(context, listen: false)
                              .changeState(true);
                        }
                      },
                      icon: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: kAccentColor,
                        child: Icon(
                          Iconsax.message,
                          size: 25.r,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15.sp,
                    backgroundColor: kPrimaryColor1.withOpacity(0.3),
                    child: Text(
                      value.isLoading
                          ? "Loading"
                          : value.model!.user![0].toUpperCase(),
                      style: layer2,
                    ),
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isLoading ? "Loading" : value.model!.user ?? "",
                    style: layer2,
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isLoading
                        ? "Loading"
                        : DateFormat("EEEE, MMM d, yyyy")
                            .format(DateTime.parse(value.model!.updatedAt!)),
                    style: layer2,
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
