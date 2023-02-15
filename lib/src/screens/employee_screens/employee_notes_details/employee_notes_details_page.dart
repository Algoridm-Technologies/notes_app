import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/update_note_api.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/reply_other_tile.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';
import 'package:undo/undo.dart';

import '../../../api/note_reply_api.dart';
import '../../../provider/database/employee_note_provider.dart';
import '../../../utils/refresh_token.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/default_button.dart';
import '../../../widget/outline_button.dart';
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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bodyTextController.addListener(() {
        setState(() {});
      });
    });
  }

  var isReplying = false;
  List vn = [1, 2, 1, 2, 1, 1, 2, 1, 2, 1];
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDetailEmployeeProvider>(
      builder: (context, value, child) {
        return WillPopScope(
          onWillPop: () async {
            showExitDialog(value);
            return false;
          },
          child: Scaffold(
              appBar: AppBar(
                leading: Container(
                  height: 5,
                  width: 5,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kWhiteColor,
                  ),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showExitDialog(value);
                      },
                      icon: const Icon(Iconsax.arrow_left_2)),
                ),
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
                                color:
                                    changes.canRedo ? kTextColor1 : kGreyColor,
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
                        if (tileTextController.text.isEmpty ||
                            bodyTextController.text.isEmpty) {
                          CustomSnackBar.showSnackbar(
                              context: context,
                              title: "Body or title field cannot be empty");
                          return;
                        }
                        addEdit(noteId: value.model!.id!, pop: false);
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
              bottomSheet: Consumer<SetStateProvider>(
                builder: (context, v, child) {
                  return v.isReplying
                      ? const SizedBox()
                      : Consumer<NoteDetailEmployeeProvider>(
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
                                     value.list.isEmpty?const SizedBox():   GestureDetector(
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
                                    child: value.list.isEmpty
                                        ? const Center(
                                            child: Text("No Replies"),
                                          )
                                        : ListView.builder(
                                            padding: screenPadding,
                                            itemCount: value.list.length,
                                            itemBuilder: (c, i) {
                                              return ReplyOtherTile(
                                                reply: value.list[i],
                                              );
                                            },
                                          ),
                                  ),
                                  value.list.isEmpty
                                      ? const Center(
                                          child: SizedBox(),
                                        )
                                      : Container(
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Center(
                                                    child: TextField(
                                                      controller:
                                                          replyController,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              isLoading
                                                  ? CircleAvatar(
                                                      radius: 20.r,
                                                      child:
                                                          CupertinoActivityIndicator(
                                                        radius: 15.r,
                                                      ))
                                                  : CircleAvatar(
                                                      radius: 20.r,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          var noteId = Provider
                                                                  .of<NoteDetailEmployeeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                              .model!
                                                              .id!;
                                                          sendReply(
                                                              noteId: noteId,
                                                              replyId: value
                                                                  .list
                                                                  .last
                                                                  .id!,
                                                              text:
                                                                  replyController
                                                                      .text);
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
                        );
                },
              )),
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
                                    decoration: InputDecoration(
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

  addEdit({required String noteId, required bool pop}) async {
    ProcessingDialog.showProcessingDialog(
        context: context, title: "Editing Note", subtitle: "Editing note Note");
    await RefreshToken.refreshToken().then((value) async {
      await UpdateNoteApi.updateNote(
              title: tileTextController.text,
              text: bodyTextController.text,
              noteId: noteId)
          .then((value) {
        print(value);
        Provider.of<EmployeeNoteProvider>(context, listen: false).getFacility();

        ProcessingDialog.cancelDialog(context);
        if (pop) Navigator.pop(context);
        Navigator.pop(context);
        if (jsonDecode(value)['id'] != null) {
          CustomSnackBar.showSnackbar(context: context, title: "Note Updated");
        } else {
          CustomSnackBar.showSnackbar(
              context: context, title: "Something went wrong");
        }
      });
    });
  }

  showExitDialog(NoteDetailEmployeeProvider value) {
    showDialog(
      context: context,
      builder: (context) {
        return editDialogBody(value);
      },
    );
  }

  Widget editDialogBody(NoteDetailEmployeeProvider value) {
    return AlertDialog(
      content: SizedBox(
        height: 300.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close)),
              ),
            ),
            Text(
              "Save Or Discard Changes?",
              style: heading2,
            ),
            Text(
              "Do you want to Save your Changes Or Discard Them?",
              textAlign: TextAlign.center,
              style: layer2,
            ),
            DefaultButton(
                widget: Text(
                  "Save",
                  style: buttonWhite,
                ),
                onTap: () {
                  if (tileTextController.text.isEmpty ||
                      bodyTextController.text.isEmpty) {
                    CustomSnackBar.showSnackbar(
                        context: context,
                        title: "Body or title field cannot be empty");
                    Navigator.pop(context);
                    return;
                  }
                  addEdit(noteId: value.model!.id!, pop: true);
                }),
            OutlineButton(
                widget: Text(
                  "Discard",
                  style: buttonPrimary,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
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
