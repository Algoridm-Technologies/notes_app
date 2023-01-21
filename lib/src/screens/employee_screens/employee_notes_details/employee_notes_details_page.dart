import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:note/src/widget/reply_other_tile.dart';
import 'package:note/src/widget/reply_user_tile.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:undo/undo.dart';

import 'components/header_tile.dart';

class EmployeeNotesDetailPage extends StatefulWidget {
  const EmployeeNotesDetailPage({Key? key}) : super(key: key);

  @override
  State<EmployeeNotesDetailPage> createState() =>
      _EmployeeNotesDetailPageState();
}

class _EmployeeNotesDetailPageState extends State<EmployeeNotesDetailPage> {
  var controller = TextEditingController();
  var changes = ChangeStack();
  var body = "";
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  var isReplying = false;
  List vn = [1, 2, 1, 2, 1, 1, 2, 1, 2, 1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: customBackButton(context),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: () {
                  if (changes.canUndo) {
                    changes.undo();
                    controller.text = body;

                    controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length));
                  }
                },
                icon: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: changes.canUndo ? kTextColor1 : kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        8.r,
                      )),
                  child: Icon(
                    Iconsax.undo,
                    color: changes.canUndo ? kTextColor1 : kGreyColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                  onPressed: () {
                    if (changes.canRedo) {
                      changes.redo();
                      controller.text = body;

                      controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.text.length));
                    }
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: changes.canRedo ? kTextColor1 : kGreyColor,
                        ),
                        borderRadius: BorderRadius.circular(
                          8.r,
                        )),
                    child: Icon(
                      Iconsax.redo,
                      color: changes.canRedo ? kTextColor1 : kGreyColor,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.more,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            const HeaderTile(),
            Expanded(
              child: ListView(
                padding: screenPadding,
                physics: const BouncingScrollPhysics(),
                children: [
                  const VerticalGap(gap: 20),
                  Text(
                    loremSentence,
                    style: layer2,
                  ),
                  const VerticalGap(gap: 400),
                ],
              ),
            )
          ],
        ),
        bottomSheet: SizedBox(
          height: 400.h,
          child: Column(
            children: [
              const VerticalGap(gap: 20),
              Padding(
                padding: screenPadding,
                child: Row(
                  children: [
                    Text(
                      "Replies",
                      style: layer1,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showButtonSheet();
                      },
                      child: Hero(
                        tag: "text",
                        child: Text(
                          "View All",
                          style: layer1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalGap(gap: 20),
              Expanded(
                child: ListView.builder(
                  padding: screenPadding,
                  itemCount: 10,
                  itemBuilder: (c, i) {
                    return vn[i] == 1
                        ? const ReplyOtherTile()
                        : const ReplyUserTile();
                  },
                ),
              ),
              Container(
                margin: screenPadding,
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                height: 54.h,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        decoration: BoxDecoration(
                          color: kGreyColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: Icon(
                                Iconsax.microphone_slash_1,
                                size: 25.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 20.r,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          size: 25.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  showButtonSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return buildSheet();
        });
  }

  Widget buildSheet() {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        // snap: true,
        builder: (context, s) {
          return Container(
            decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Scaffold(
              body: Column(
                children: [
                  const VerticalGap(gap: 20),
                  Padding(
                    padding: screenPadding,
                    child: Center(
                        child: Hero(
                            tag: "text",
                            child: Text(
                              "All Replies",
                              style: heading3,
                            ))),
                  ),
                  const VerticalGap(gap: 20),
                  Expanded(
                    child: ListView.builder(
                      padding: screenPadding,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (c, i) {
                        return vn[i] == 1
                            ? const ReplyOtherTile()
                            : const ReplyUserTile();
                      },
                    ),
                  ),
                  Container(
                    margin: screenPadding,
                    padding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    height: 54.h,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            decoration: BoxDecoration(
                              color: kGreyColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  suffixIcon: Icon(
                                    Iconsax.microphone_slash_1,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 20.r,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
