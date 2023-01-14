import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalGap extends StatelessWidget {
  final double gap;
  const HorizontalGap({Key? key, required this.gap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gap.w,
    );
  }
}
