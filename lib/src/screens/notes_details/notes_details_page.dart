import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:note/src/screens/notes_details/components/header_tile.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_appbar.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

class NotesDetailPage extends StatefulWidget {
  const NotesDetailPage({Key? key}) : super(key: key);

  @override
  State<NotesDetailPage> createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  var controller = TextEditingController();
  var isReplying = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<SetStateProvider>(builder: (context, v, c) {
      return Scaffold(
        appBar: CustomAppBar(
          title: '',
        ),
        body: Column(
          children: [
            const HeaderTile(),
            Expanded(
              child: ListView(
                padding: screenPadding,
                children: [
                  const VerticalGap(gap: 20),
                  Text(
                    loremSentence,
                    style: layer2,
                  ),
                  const VerticalGap(gap: 20),
                ],
              ),
            )
          ],
        ),
        bottomSheet: v.isReplying
            ? const SizedBox()
            : Container(
                margin: screenPadding,
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                height: 44.h,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          color: kGreyColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Iconsax.microphone_slash_1,
                              size: 25.sp,
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
      );
    });
  }
}
