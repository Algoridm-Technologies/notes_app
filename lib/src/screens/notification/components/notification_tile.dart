import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/src/model/notification_model.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:note/src/widget/vertical_gap.dart';

class NotificationTile extends StatelessWidget {
  final VoidCallback onTap;
  final NotificationModel model;
  const NotificationTile({Key? key, required this.onTap, required this.model})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            child: Row(
              children: [
                const HorizontalGap(gap: 24),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    children: const [
                      CircleAvatar(
                        radius: double.infinity,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                const HorizontalGap(gap: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "You have A note Reply on ${DateFormat.MMMMEEEEd().format(DateTime.parse(model.timestamp!))} From ${model.sender!.name}"),
                      Text(Jiffy(DateTime.parse(model.timestamp!)).fromNow())
                    ],
                  ),
                ),
                const HorizontalGap(gap: 24),
              ],
            ),
          ),
        ),
        const VerticalGap(gap: 10),
      ],
    );
  }
}
