import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants.dart';

class NoteHeaderTile extends StatelessWidget {
  const NoteHeaderTile({Key? key}) : super(key: key);
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
              Text(
                "All Notes",
                style: heading1,
              ),
            ],
          ),
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
