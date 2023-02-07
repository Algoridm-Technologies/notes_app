import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/update_note_api.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:note/src/widget/reply_other_tile.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';
import 'package:undo/undo.dart';

import '../../../api/note_reply_api.dart';
import '../../../provider/database/employee_note_provider.dart';
import '../../../utils/refresh_token.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/processing_dialogue.dart';
import 'components/header_tile.dart';

class EmployeeNotesDetailPage extends StatefulWidget {
  const EmployeeNotesDetailPage({Key? key}) : super(key: key);

  @override
  State<EmployeeNotesDetailPage> createState() =>
      _EmployeeNotesDetailPageState();
}

class _EmployeeNotesDetailPageState extends State<EmployeeNotesDetailPage> {
  var bodyTextController = TextEditingController();
  var tileTextController = TextEditingController();
  var replyController = TextEditingController();
  var changes = ChangeStack();
  var body = "";
  @override
  void initState() {
    super.initState();
    bodyTextController.addListener(() {
      setState(() {});
    });
  }

  var isReplying = false;
  List vn = [1, 2, 1, 2, 1, 1, 2, 1, 2, 1];
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDetailEmployeeProvider>(
      builder: (context, value, child) {
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
                        bodyTextController.text = body;

                        bodyTextController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: bodyTextController.text.length));
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
                          bodyTextController.text = body;

                          bodyTextController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: bodyTextController.text.length));
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
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {
                      addEdit(noteId: value.model!.id!);
                    },
                    icon: const Icon(
                      Icons.save,
                    ),
                  ),
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
                HeaderTile(tileTextController: tileTextController),
                Expanded(
                  child: Consumer<NoteDetailEmployeeProvider>(
                    builder: (context, value, child) {
                      if (value.model != null) {
                        if (bodyTextController.text.isEmpty) {
                          bodyTextController.text = value.model!.text ?? "";
                        }
                      }
                      return ListView(
                        padding: screenPadding,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const VerticalGap(gap: 20),
                          TextField(
                            controller: bodyTextController,
                            onChanged: (value) {
                              changes.add(Change(
                                  body, () => body = value, (v) => body = v,
                                  description: "increase"));

                              // controller.selection = TextSelection.fromPosition(
                              //     TextPosition(offset: controller.text.length));
                            },
                            style: heading3,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Title Goes Here",
                              hintStyle: heading3,
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                          // Text(
                          //   value.model == null
                          //       ? "Loading"
                          //       : value.model!.text ?? "",
                          //   style: layer2,
                          // ),
                          const VerticalGap(gap: 400),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
            bottomSheet: Consumer<NoteDetailEmployeeProvider>(
              builder: (context, value, child) {
                return SizedBox(
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
                                onPressed: () {
                                  var noteId =
                                      Provider.of<NoteDetailEmployeeProvider>(
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
                );
              },
            ));
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
                            return ListView.builder(
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
                                onPressed: () {
                                  var noteId =
                                      Provider.of<NoteDetailEmployeeProvider>(
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

  addEdit({required String noteId}) async {
    ProcessingDialog.showProcessingDialog(
        context: context, title: "Editing Note", subtitle: "Editing note Note");
    await UpdateNoteApi.updateNote(
            title: tileTextController.text,
            text: bodyTextController.text,
            noteId: noteId)
        .then((value) {
      Provider.of<EmployeeNoteProvider>(context, listen: false).getFacility();

      ProcessingDialog.cancelDialog(context);
      if (jsonDecode(value)['success'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['success']);
      }
      if (jsonDecode(value)['email'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['email'][0]);
      }
    });
  }

  sendReply({
    required String noteId,
    required String replyId,
    required String text,
  }) async {
    await RefreshToken.refreshToken();
    print('object');
    await NoteReplyApi.noteReply(noteId: noteId, replyId: replyId, text: text)
        .then((value) {
      print(value);
      Provider.of<NoteDetailEmployeeProvider>(context, listen: false)
          .getFacility(noteId);
    });
  }
}
