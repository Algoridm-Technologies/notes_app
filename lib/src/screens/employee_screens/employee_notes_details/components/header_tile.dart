import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/provider/database/profile_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../../../api/note_reply_api.dart';
import '../../../../provider/util/setstate_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/refresh_token.dart';
import '../../../../widget/horizontal_gap.dart';
import '../../../../widget/reply_other_tile.dart';
import '../../../../widget/vertical_gap.dart';

class HeaderTile extends StatefulWidget {
  final TextEditingController tileTextController;
  final bool isUser;
  const HeaderTile(
      {Key? key, required this.tileTextController, required this.isUser})
      : super(key: key);

  @override
  State<HeaderTile> createState() => _HeaderTileState();
}

class _HeaderTileState extends State<HeaderTile> {
  var replyController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDetailEmployeeProvider>(
      builder: (context, value, child) {
        if (value.model != null) {
          if (widget.tileTextController.text.isEmpty) {
            widget.tileTextController.text = value.model!.title ?? "";
          }
        }
        return Column(
          children: [
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  const Icon(Iconsax.note_favorite),
                  const HorizontalGap(gap: 20),
                  Consumer<ProfileDetailProvider>(
                      builder: (context, value, child) {
                    return Text(
                      '${value.model!.facility} Facility',
                      style: heading3,
                    );
                  }),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: heading1,
                      readOnly: widget.isUser,
                      controller: widget.tileTextController,
                      decoration: InputDecoration(
                        hintText: "Title Goes Here",
                        hintStyle: heading1,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  // Text(
                  //   value.model == null ? "Loading" : value.model!.title ?? "",
                  //   style: heading1,
                  // ),
                  // const Spacer(),
                  IconButton(
                    onPressed: () {
                      // if (Provider.of<SetStateProvider>(context, listen: false)
                      //     .isReplying) {
                      //   Provider.of<SetStateProvider>(context, listen: false)
                      //       .changeState(false);
                      // } else {
                      //   Provider.of<SetStateProvider>(context, listen: false)
                      //       .changeState(true);
                      // }
                    },
                    icon: IconButton(
                      onPressed: () {
                        showButtonSheet();
                      },
                      icon: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: kAccentColor,
                        child: Icon(
                          Iconsax.message,
                          size: 25.r,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15.sp,
                    backgroundColor: kPrimaryColor1.withOpacity(0.3),
                    child: Text(
                      value.isLoading
                          ? "Loading"
                          : value.model!.user![0].toUpperCase(),
                      style: layer2,
                    ),
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isLoading ? "Loading" : value.model!.user ?? "",
                    style: layer2,
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isLoading
                        ? "Loading"
                        : DateFormat("EEEE, MMM d, yyyy")
                            .format(DateTime.parse(value.model!.updatedAt!)),
                    style: layer2,
                  )
                ],
              ),
            )
          ],
        );
      },
    );
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
          return Consumer<NoteDetailEmployeeProvider>(
            builder: (context, value, child) {
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
                        child: Consumer<NoteDetailEmployeeProvider>(
                          builder: (context, value, child) {
                            return value.list.isEmpty
                                ? const Center(
                                    child: Text("No Replies"),
                                  )
                                : ListView.builder(
                                    padding: screenPadding,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: value.list.length,
                                    itemBuilder: (c, i) {
                                      return ReplyOtherTile(
                                        reply: value.list[i],
                                      );
                                    },
                                  );
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
                                    controller: replyController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            isLoading
                                ? CircleAvatar(
                                    radius: 20.r,
                                    child: CupertinoActivityIndicator(
                                      radius: 15.r,
                                    ))
                                : CircleAvatar(
                                    radius: 20.r,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        var noteId = Provider.of<
                                                    NoteDetailEmployeeProvider>(
                                                context,
                                                listen: false)
                                            .model!
                                            .id!;
                                        sendReply(
                                            noteId: noteId,
                                            replyId: value.list.last.id!,
                                            text: replyController.text);
                                      },
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
            },
          );
        });
  }

  sendReply({
    required String noteId,
    required String replyId,
    required String text,
  }) async {
    await RefreshToken.refreshToken();

    await NoteReplyApi.noteReply(noteId: noteId, replyId: replyId, text: text)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      Provider.of<NoteDetailEmployeeProvider>(context, listen: false)
          .getNoteDetails(noteId);
    });
  }
}
