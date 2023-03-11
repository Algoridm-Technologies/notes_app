import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/delete_note_api.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:note/src/widget/custom_snackbar.dart';
import 'package:note/src/widget/processing_dialogue.dart';
import 'package:provider/provider.dart';

import 'components/note_header_tile.dart';
import 'components/notes_list.dart';

class EmployerNotesPage extends StatelessWidget {
  const EmployerNotesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckProvider>(builder: (context, v, c) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
           
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: screenPadding,
              child: const NoteHeaderTile(),
            ),
            Expanded(
              child: Padding(
                padding: screenPadding,
                child: const NotesList(),
              ),
            ),
          ],
        ),
        bottomSheet: v.isChecking
            ? SizedBox(
                height: 80,
                width: double.infinity,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        ProcessingDialog.showProcessingDialog(
                            context: context,
                            title: "Deleting Note",
                            subtitle: 'Deleting this note(s)');
                        var list = v.positions;
                        await RefreshToken.refreshToken();
                        await DeleteNoteApi.deleteNote(id: list).then((value) {
                         
                          ProcessingDialog.cancelDialog(context);
                          if (jsonDecode(value)['success'] != null) {
                            Provider.of<CheckProvider>(context, listen: false)
                                .changeIsChecking(false);
                            CustomSnackBar.showSnackbar(
                                context: context,
                                title: jsonDecode(value)['success']);
                            Provider.of<EmployeeAndNoteProvider>(context,
                                    listen: false)
                                .getFacility();
                          }
                        });
                      },
                      icon: const Icon(
                        Iconsax.trash,
                      ),
                    ),
                    const Text("Delete")
                  ],
                ),
              )
            : const SizedBox(),
      );
    });
  }
}
