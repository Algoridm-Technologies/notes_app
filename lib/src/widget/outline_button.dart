import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/utils/constants.dart';

class OutlineButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onTap;
  const OutlineButton({Key? key, required this.widget, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: kPrimaryColor1,
            width: 1.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onTap,
        child: widget,
      ),
    );
  }
}
