import 'package:flutter/material.dart';
import 'package:note/src/utils/constants.dart';

class OutlineButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onTap;
  const OutlineButton({Key? key, required this.widget, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: kPrimaryColor1,
            width: 2,
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
