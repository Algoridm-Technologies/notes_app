import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:note/src/provider/database/note_detail_employer_provider.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../widget/horizontal_gap.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDetailEmployerProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  const Icon(Iconsax.note_favorite),
                  const HorizontalGap(gap: 20),
                  Text(
                    'Nazasmart Facility',
                    style: heading3,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.trash,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  Text(
                    value.isEmpty ? "" : value.model!.title!,
                    style: heading1,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (Provider.of<SetStateProvider>(context, listen: false)
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
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15.sp,
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isEmpty ? "" : value.model!.user!,
                    style: layer2,
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isEmpty
                        ? ""
                        : "${DateFormat().format(DateTime.parse(value.model!.createdAt!))}  ",
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
