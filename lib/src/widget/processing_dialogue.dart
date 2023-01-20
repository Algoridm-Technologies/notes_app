import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/utils/constants.dart';

class ProcessingDialog {
  static showProcessingDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
            content: SizedBox(
              height: 300.h,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircularProgressIndicator.adaptive(),
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
                ],
              ),
            ),
          );
        });
  }

  static cancelDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
