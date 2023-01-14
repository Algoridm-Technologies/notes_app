import 'package:flutter/material.dart';
import 'package:note/src/utils/constants.dart';

class DefaultButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onTap;
  final Color? color;
  const DefaultButton(
      {Key? key, required this.widget, required this.onTap, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? kPrimaryColor1,
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
