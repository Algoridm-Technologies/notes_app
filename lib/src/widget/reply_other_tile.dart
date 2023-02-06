import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/src/model/note_detail_model.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/vertical_gap.dart';

class ReplyOtherTile extends StatelessWidget {
  final Replies reply;
  const ReplyOtherTile({Key? key, required this.reply}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
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
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(0),
                  )),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      reply.user!,
                      style: GoogleFonts.inter(
                        color: kPrimaryColor1,
                      ),
                    ),
                  ),
                  Text(reply.text??""),
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
            const Spacer(),
          ],
        ),
        const VerticalGap(gap: 20),
      ],
    );
  }
}
