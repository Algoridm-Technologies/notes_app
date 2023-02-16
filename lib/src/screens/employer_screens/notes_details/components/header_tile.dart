import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:note/src/provider/database/current_facility_provider.dart';
import 'package:note/src/provider/database/note_detail_employer_provider.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:provider/provider.dart';

import '../../../../api/delete_note_api.dart';
import '../../../../provider/database/employee_and_note_provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/refresh_token.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../../widget/horizontal_gap.dart';
import '../../../../widget/processing_dialogue.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({Key? key}) : super(key: key);
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
                      if (Provider.of<SetStateProvider>(context, listen: false)
                          .isReplying) {
                        Provider.of<SetStateProvider>(context, listen: false)
                            .changeState(false);
                      } else {
                        Provider.of<SetStateProvider>(context, listen: false)
                            .changeState(true);
                      }
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
                  Text(
                    value.isEmpty ? "" : value.model!.user!,
                    style: layer2,
                  ),
                  const HorizontalGap(gap: 10),
                  Text(
                    value.isEmpty
                        ? ""
                        : "${DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(value.model!.createdAt!))}  ",
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
}
