import 'package:flutter/material.dart';
import 'package:note/src/screens/add_facility/add_facility_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/vertical_gap.dart';

class EmployerFacilitiesPage extends StatelessWidget {
  const EmployerFacilitiesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            const VerticalGap(gap: 50),
            Expanded(
              child: LayoutBuilder(builder: (context, value) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1 / 2 / 0.6,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            color: kSecondaryColor,
                          ),
                          Text("Facility $index"),
                          const Text("data"),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            DefaultButton(
              widget: Text(
                "Add Facility",
                style: heading3White,
              ),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: kAnimationDuration,
                    pageBuilder: ((context, animation, _) {
                      return FadeTransition(
                        opacity: animation,
                        child: const AddFacilityPage(),
                      );
                    }),
                  ),
                );
              },
            ),
            const VerticalGap(gap: 50),
          ],
        ),
      ),
    );
  }
}
