import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/widget/horizontal_gap.dart';

class StaffNoteHeaderTile extends StatelessWidget {
  const StaffNoteHeaderTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(),
            ],
          ),
          const HorizontalGap(gap: 10),
          const Text('Koln Mark'),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.search_normal,
            ),
          ),
        ],
      ),
    );
  }
}
