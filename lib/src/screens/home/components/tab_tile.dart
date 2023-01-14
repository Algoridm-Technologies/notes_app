import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/navigation/navigation_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

class TabTile extends StatelessWidget {
  const TabTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(children: [
        tile(
          title: "All Staff",
          subtitle: "Click to view All Staff",
          icon: Iconsax.people,
          background: kPrimaryColor1,
          onTap: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .changePage(1);
          },
        ),
        const SizedBox(width: 20),
        tile(
          title: "All Notes",
          subtitle: "Click to view All Notes",
          icon: Iconsax.note_21,
          background: kSecondaryColor,
          onTap: () {
            Provider.of<NavigationProvider>(context, listen: false)
                .changePage(3);
          },
        ),
      ]),
    );
  }

  Widget tile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color background,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Material(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Ink(
              height: 160.h,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon,
                    color: kWhiteColor,
                    size: 30,
                  ),
                  Text(
                    title,
                    style: heading2White,
                  ),
                  Text(
                    subtitle,
                    style: subTitle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
