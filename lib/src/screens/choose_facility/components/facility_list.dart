import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/provider/database/facility_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';

class FacilityList extends StatefulWidget {
  const FacilityList({Key? key}) : super(key: key);

  @override
  State<FacilityList> createState() => _FacilityListState();
}

class _FacilityListState extends State<FacilityList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FacilityProvider>(context, listen: false).getFacility();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FacilityProvider>(
      builder: (context, model, child) {
        var newList = model.list;
        return model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : newList.isEmpty
                ? const Center(child: Text("No item"))
                : Consumer<CheckProvider>(builder: (context, v, c) {
                    return SizedBox(
                      height: 300.h,
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: newList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      image: DecorationImage(image: NetworkImage(newList[index]!.image??"")),
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
      },
    );
  }
}
