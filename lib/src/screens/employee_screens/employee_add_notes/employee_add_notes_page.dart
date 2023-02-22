import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/add_note_api.dart';
import 'package:note/src/provider/database/employee_note_provider.dart';

import 'package:note/src/utils/constants.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:provider/provider.dart';
import 'package:undo/undo.dart';

import '../../../widget/custom_snackbar.dart';
import '../../../widget/default_button.dart';
import '../../../widget/outline_button.dart';
import '../../../widget/processing_dialogue.dart';

class EmployeeAddNotesPage extends StatefulWidget {
  const EmployeeAddNotesPage({Key? key}) : super(key: key);

  @override
  State<EmployeeAddNotesPage> createState() => _EmployeeAddNotesPageState();
}

class _EmployeeAddNotesPageState extends State<EmployeeAddNotesPage> {
  var bodyTextController = TextEditingController();
  var titleTextController = TextEditingController();
  var changes = ChangeStack();
  var body = "";
  @override
  void initState() {
    super.initState();
    bodyTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (changes.canRedo ||
            changes.canUndo ||
            titleTextController.text.isNotEmpty ||
            bodyTextController.text.isNotEmpty) {
          showExitDialog();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
                  if (changes.canRedo ||
                      changes.canUndo ||
                      titleTextController.text.isNotEmpty ||
                      bodyTextController.text.isNotEmpty) {
                    showExitDialog();
                  } else {
                    Navigator.pop(context);
                  }
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

                    bodyTextController.selection = TextSelection.fromPosition(
                        TextPosition(offset: bodyTextController.text.length));
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

                      bodyTextController.selection = TextSelection.fromPosition(
                          TextPosition(offset: bodyTextController.text.length));
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
                  if (titleTextController.text.isEmpty ||
                      bodyTextController.text.isEmpty) {
                    CustomSnackBar.showSnackbar(
                        context: context,
                        title: "Body or title field cannot be empty");
                    return;
                  }
                  addNote(false);
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
            Padding(
              padding: screenPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.note_favorite),
                      const HorizontalGap(gap: 20),
                      Text(
                        'Work  Notes',
                        style: heading3,
                      ),
                    ],
                  ),
                  TextField(
                    style: heading1,
                    controller: titleTextController,
                    decoration: InputDecoration(
                      hintText: "Title Goes Here",
                      hintStyle: heading1,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: screenPadding,
                child: TextField(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  showExitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return editDialogBody();
      },
    );
  }

  Widget editDialogBody() {
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
                  if (titleTextController.text.isEmpty ||
                      bodyTextController.text.isEmpty) {
                    CustomSnackBar.showSnackbar(
                        context: context,
                        title: "Body or title field cannot be empty");
                    Navigator.pop(context);
                    return;
                  }
                  addNote(true);
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

  addNote(bool pop) async {
    ProcessingDialog.showProcessingDialog(
        context: context, title: "Adding Note", subtitle: "Adding new Note");
    await RefreshToken.refreshToken().then((value) async {
      await AddNoteApi.addNote(
        title: titleTextController.text,
        body: bodyTextController.text,
      ).then((value) {
        Provider.of<EmployeeNoteProvider>(context, listen: false)
            .getNotesAndEmployee();

        ProcessingDialog.cancelDialog(context);
        if (pop) Navigator.pop(context);
        Navigator.pop(context);
        if (jsonDecode(value)['id'] != null) {
          CustomSnackBar.showSnackbar(context: context, title: "Note added");
        } else {
          CustomSnackBar.showSnackbar(
            backgroundColor: kErrorColor1,
              context: context, title: "something went wrong");
        }
      });
    });
  }
}
