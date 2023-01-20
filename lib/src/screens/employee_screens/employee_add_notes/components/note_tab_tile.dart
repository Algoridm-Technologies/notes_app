import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/provider/util/tab_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';

class NoteTabTile extends StatelessWidget {
  const NoteTabTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(builder: (context, v, c) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5.r,
          ),
          color: kPrimaryColor1,
        ),
        height: 50,
        padding: const EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                v.changeState(0);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: v.tab == 0 ? kWhiteColor : kTransparentColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  "Your Notes",
                  style: v.tab == 0 ? heading3 : heading3White,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                v.changeState(1);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: v.tab == 1 ? kWhiteColor : kTransparentColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  "Others",
                  style: v.tab == 1 ? heading3 : heading3White,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
