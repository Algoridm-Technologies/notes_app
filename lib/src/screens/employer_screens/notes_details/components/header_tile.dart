import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:note/src/provider/database/current_facility_provider.dart';
import 'package:note/src/provider/database/note_detail_employer_provider.dart';
import 'package:provider/provider.dart';

import '../../../../api/delete_note_api.dart';
import '../../../../api/note_reply_api.dart';
import '../../../../provider/database/employee_and_note_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/refresh_token.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../../widget/horizontal_gap.dart';
import '../../../../widget/processing_dialogue.dart';
import '../../../../widget/reply_other_tile.dart';
import '../../../../widget/vertical_gap.dart';

class HeaderTile extends StatefulWidget {
  const HeaderTile({Key? key}) : super(key: key);

  @override
  State<HeaderTile> createState() => _HeaderTileState();
}

class _HeaderTileState extends State<HeaderTile> {
  var replyController = TextEditingController();
  var loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDetailEmployerProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  const Icon(Iconsax.note_favorite),
                  const HorizontalGap(gap: 20),
                  Consumer<CurrentFacilityProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.isLoggedIn
                            ? value.model!.facilityName ?? ""
                            : ' ',
                        style: heading3,
                      );
                    },
                  ),
                  const Spacer(),
                  value.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CupertinoActivityIndicator(),
                        )
                      : IconButton(
                          onPressed: () async {
                            ProcessingDialog.showProcessingDialog(
                                context: context,
                                title: "Deleting Note",
                                subtitle: 'Deleting this note(s)');
                            var list = <String>[value.model!.id!];
                            await RefreshToken.refreshToken();
                            await DeleteNoteApi.deleteNote(id: list)
                                .then((value) {
                              ProcessingDialog.cancelDialog(context);
                              if (jsonDecode(value)['success'] != null) {
                                CustomSnackBar.showSnackbar(
                                    context: context,
                                    title: jsonDecode(value)['success']);
                                Provider.of<EmployeeAndNoteProvider>(context,
                                        listen: false)
                                    .getFacility();
                                Navigator.pop(context);
                              }
                            });
                          },
                          icon: const Icon(
                            Iconsax.trash,
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  Text(
                    value.isEmpty ? "" : value.model!.title!,
                    style: heading1,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showButtonSheet(context);
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
                ],
              ),
            ),
            Padding(
              padding: screenPadding,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15.sp,
                    backgroundColor: kPrimaryColor1.withOpacity(0.2),
                    child: Text(value.isEmpty
                        ? ""
                        : value.model!.user![0].toUpperCase()),
                  ),
                  const HorizontalGap(gap: 10),
                  Expanded(
                    child: Text(
                      value.isEmpty ? "" : value.model!.user!,
                      maxLines: 1,
                      style: layer2,
                    ),
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isEmpty
                        ? ""
                        : "${DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(value.model!.createdAt!))}  ",
                    overflow: TextOverflow.ellipsis,
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

  showButtonSheet(BuildContext con) {
    showModalBottomSheet(
        context: con,
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
          return Consumer<NoteDetailEmployerProvider>(
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
                        child: value.list.isEmpty
                            ? const Center(child: Text("No reply"))
                            : ListView.builder(
                                padding: screenPadding,
                                physics: const BouncingScrollPhysics(),
                                itemCount: value.list.length,
                                itemBuilder: (c, i) {
                                  return ReplyOtherTile(
                                    reply: value.list[i],
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
                            Consumer<NoteDetailEmployerProvider>(
                                builder: (context, p, _) {
                              return value.isProcessing
                                  ? CircleAvatar(
                                      radius: 30.r,
                                      child: CupertinoActivityIndicator(
                                        radius: 15.r,
                                      ))
                                  : CircleAvatar(
                                      radius: 30.r,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            if (replyController.text.isEmpty) {
                                              return;
                                            }
                                            p.setisProcessing(true);

                                            sendReply(
                                                noteId: value.model!.id!,
                                                replyId: "",
                                                text: replyController.text);
                                          },
                                          icon: Icon(
                                            Icons.send,
                                            size: 25.sp,
                                          ),
                                        ),
                                      ),
                                    );
                            }),
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
    await NoteReplyApi.noteReply(
      noteId: noteId,
      replyId: replyId,
      text: text,
    ).then((value) {
      Navigator.pop(context);
      Provider.of<NoteDetailEmployerProvider>(context, listen: false)
          .setisProcessing(false);
      Provider.of<NoteDetailEmployerProvider>(context, listen: false)
          .getFacility(noteId);
    });
  }
}
