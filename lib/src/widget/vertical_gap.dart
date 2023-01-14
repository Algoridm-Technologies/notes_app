import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalGap extends StatelessWidget {
  final double gap;
  const VerticalGap({Key? key, required this.gap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gap.h,
    );
  }
}
