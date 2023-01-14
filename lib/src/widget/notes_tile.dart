import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/vertical_gap.dart';

import '../utils/constants.dart';

class NotesTile extends StatelessWidget {
  final bool isUser;
  final VoidCallback onTap;
  const NotesTile({Key? key, required this.isUser, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 140.sp,
      child: Material(
        child: Card(
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
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5.sp,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lessons",
                        style: layer1,
                      ),
                      const VerticalGap(gap: 2),
                      Text(
                        "Duis veniam qui tempor laborum. Eu occaecat dolor cupidatat ullamco irure Lorem qui velit nostrud. Tempor veniam laborum aliquip cupidatat sint culpa do nostrud nisi veniam esse esse. Qui eiusmod in ad irure nisi. Aliqua id laborum voluptate exercitation ea magna sit eu sit veniam est amet.",
                        style: subTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const VerticalGap(gap: 5),
                      Row(
                        children: [
                          isUser
                              ? const SizedBox()
                              : CircleAvatar(
                                  radius: 15.sp,
                                ),
                          isUser
                              ? const SizedBox()
                              : const HorizontalGap(gap: 10),
                          isUser
                              ? const SizedBox()
                              : Text(
                                  "Koln Mark",
                                  style: subTitle,
                                ),
                          isUser
                              ? const SizedBox()
                              : const HorizontalGap(gap: 10),
                          Text(
                            "December 02 2022",
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
      ),
    );
  }
}