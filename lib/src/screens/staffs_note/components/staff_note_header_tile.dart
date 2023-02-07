import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/widget/horizontal_gap.dart';

class StaffNoteHeaderTile extends StatelessWidget {
  final String name;
  final String image;
  const StaffNoteHeaderTile({Key? key, required this.name, required this.image})
      : super(key: key);
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
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
            ],
          ),
          const HorizontalGap(gap: 10),
          Text(name),
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
