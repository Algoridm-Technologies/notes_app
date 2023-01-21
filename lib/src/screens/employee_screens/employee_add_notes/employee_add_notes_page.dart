import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:undo/undo.dart';

class EmployeeAddNotesPage extends StatefulWidget {
  const EmployeeAddNotesPage({Key? key}) : super(key: key);

  @override
  State<EmployeeAddNotesPage> createState() => _EmployeeAddNotesPageState();
}

class _EmployeeAddNotesPageState extends State<EmployeeAddNotesPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                controller: controller,
                onChanged: (value) {
                  changes.add(Change(body, () => body = value, (v) => body = v,
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
    );
  }
}
