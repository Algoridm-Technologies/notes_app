import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/vertical_gap.dart';

class ReplyUserTile extends StatelessWidget {
  const ReplyUserTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              width: 300.w,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: kGreyColor,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "You",
                      style: GoogleFonts.inter(
                        color: kErrorColor1,
                      ),
                    ),
                  ),
                  const Text(
                      "Veniam et ex laborum dolor commodo nostrud anim laboris eu sint labore Lorem do cillum. Ex Lorem laborum mollit consectetur dolor velit voluptate est esse dolor dolore. Id ipsum ipsum proident aute adipisicing mollit non. Reprehenderit cupidatat eiusmod labore et Lorem officia cupidatat. Et fugiat dolore magna nostrud ad cillum pariatur veniam sit tempor. Tempor cillum voluptate in labore anim mollit eu non elit. Minim aliquip deserunt aute sint."),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "16:04",
                      style: GoogleFonts.inter(
                        color: kGreyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const VerticalGap(gap: 20),
      ],
    );
  }
}
