import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/api/note_reply_api.dart';
import 'package:note/src/provider/database/note_detail_employer_provider.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:note/src/screens/employer_screens/notes_details/components/header_tile.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:note/src/widget/custom_appbar.dart';
import 'package:note/src/widget/reply_other_tile.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

class NotesDetailPage extends StatefulWidget {
  const NotesDetailPage({Key? key}) : super(key: key);

  @override
  State<NotesDetailPage> createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  var controller = TextEditingController();
  var replyController = TextEditingController();
  var loading = false;

  var isReplying = false;
  List vn = [1, 2, 1, 2, 1, 1, 2, 1, 2, 1];
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteDetailEmployerProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return Container(
            color: kWhiteColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
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
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const VerticalGap(gap: 20),
                    Text(
                      value.isEmpty ? "" : value.model!.text ?? "",
                      style: layer2,
                    ),
                    const VerticalGap(gap: 400),
                  ],
                ))
              ],
            ));
        // bottomSheet: Consumer<SetStateProvider>(builder: (con, v, c) {
        //   return v.isReplying
        //       ? SizedBox(
        //           height: 400.h,
        //           child: Column(
        //             children: [
        //               const VerticalGap(gap: 20),
        //               Padding(
        //                 padding: screenPadding,
        //                 child: Row(
        //                   children: [
        //                     Text(
        //                       "Replies",
        //                       style: layer1,
        //                     ),
        //                     const Spacer(),
        //                     value.list.isEmpty
        //                         ? const SizedBox()
        //                         : GestureDetector(
        //                             onTap: () {
        //                               showButtonSheet(con);
        //                             },
        //                             child: Hero(
        //                               tag: "text",
        //                               child: Text(
        //                                 "View All",
        //                                 style: layer1,
        //                               ),
        //                             ),
        //                           ),
        //                   ],
        //                 ),
        //               ),
        //               const VerticalGap(gap: 20),
        //               Expanded(
        //                 child: Consumer<NoteDetailEmployerProvider>(
        //                   builder: (context, value, child) {
        //                     return value.list.isEmpty
        //                         ? const Center(child: Text("No reply"))
        //                         : ListView.builder(
        //                             padding: screenPadding,
        //                             itemCount: value.list.length,
        //                             itemBuilder: (c, i) {
        //                               return ReplyOtherTile(
        //                                 reply: value.list[i],
        //                               );
        //                             },
        //                           );
        //                   },
        //                 ),
        //               ),
        //               Container(
        //                 margin: screenPadding,
        //                 padding: const EdgeInsets.only(
        //                   bottom: 5,
        //                 ),
        //                 height: 54.h,
        //                 width: double.infinity,
        //                 child: Row(
        //                   children: [
        //                     Expanded(
        //                       child: Container(
        //                         margin: const EdgeInsets.only(
        //                           right: 10,
        //                         ),
        //                         padding: const EdgeInsets.all(
        //                           10,
        //                         ),
        //                         decoration: BoxDecoration(
        //                           color: kGreyColor,
        //                           borderRadius: BorderRadius.circular(20),
        //                         ),
        //                         child: Center(
        //                           child: TextField(
        //                             controller: replyController,
        //                             decoration: const InputDecoration(
        //                               border: InputBorder.none,
        //                               enabledBorder: InputBorder.none,
        //                               focusedBorder: InputBorder.none,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     loading
        //                         ? CircleAvatar(
        //                             radius: 20.r,
        //                             child: CupertinoActivityIndicator(
        //                               radius: 15.r,
        //                             ))
        //                         : CircleAvatar(
        //                             radius: 20.r,
        //                             child: IconButton(
        //                               onPressed: () {
        //                                 var noteId = Provider.of<
        //                                             NoteDetailEmployerProvider>(
        //                                         context,
        //                                         listen: false)
        //                                     .model!
        //                                     .id!;
        //                                 sendReply(
        //                                     noteId: noteId,
        //                                     replyId: "",
        //                                     text: replyController.text);
        //                               },
        //                               icon: Icon(
        //                                 Icons.send,
        //                                 size: 25.sp,
        //                               ),
        //                             ),
        //                           ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         )
        //       : const SizedBox();
        // }));
      },
    );
  }



}
