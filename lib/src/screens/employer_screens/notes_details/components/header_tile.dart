import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../widget/horizontal_gap.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                'Business Approval',
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
                "Koln Mark",
                style: layer2,
              ),
              const HorizontalGap(gap: 10),
              Text(
                "December 02 2022",
                style: layer2,
              )
            ],
          ),
        )
      ],
    );
  }
}
