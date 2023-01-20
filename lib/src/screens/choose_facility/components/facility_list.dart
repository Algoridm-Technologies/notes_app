import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

class FacilityList extends StatelessWidget {
  const FacilityList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckProvider>(builder: (context, v, c) {
      return SizedBox(
        height: 300.h,
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    if (v.selected == index) {
                      v.selectTile(-1);
                    } else {
                      v.selectTile(index);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                        border: Border.all()),
                  ),
                ),
                v.selected == index
                    ? const Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          Icons.check_box,
                          color: kAccentColor,
                        ),
                      )
                    : const SizedBox()
              ],
            );
          },
        ),
      );
    });
  }
}
