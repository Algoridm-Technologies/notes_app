import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/utils/constants.dart';

Widget customBackButton(
  BuildContext context,
) {
  return Container(
    height: 5,
    width: 5,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: kWhiteColor,
    ),
    child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Iconsax.arrow_left_2)),
  );
}
