import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note/src/utils/constants.dart';

import 'default_button.dart';

class SuccessWithAddedDialog {
  static showSuccessDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (c) {
          return dialogContent(title: title, subtitle: subtitle);
        });
  }

  static cancelDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static Widget dialogContent(
      {required String title, required String subtitle}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
      ),
      content: SizedBox(
        height: 300.h,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              'assets/icons/complete.svg',
              width: 100.w,
              height: 100.h,
            ),
            Text(
              title,
              style: heading2,
              maxLines: 1,
            ),
            Text(
              subtitle,
              style: heading3,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            DefaultButton(
                widget: Text(
                  "Okay",
                  style: heading3White,
                ),
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
