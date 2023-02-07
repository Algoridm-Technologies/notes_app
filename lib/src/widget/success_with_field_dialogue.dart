import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_snackbar.dart';

class SuccessWithFieldDialog {
  static showSuccessDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String password,
  }) {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (c) {
          return dialogContent(
              title: title,
              subtitle: subtitle,
              password: password,
              context: context);
        });
  }

  static cancelDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static Widget dialogContent({
    required String title,
    required String subtitle,
    required String password,
    required BuildContext context,
  }) {
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
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kGreyColor,
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    password,
                    style: heading3,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: password))
                            .then((value) {
                          CustomSnackBar.showSnackbar(
                              context: context, title: "Copied to Clipboard");
                        });
                      },
                      child: const Icon(Icons.copy)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//de@gmail.com"
//C6RMMYdk167C
