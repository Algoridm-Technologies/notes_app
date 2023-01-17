import 'package:flutter/material.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/vertical_gap.dart';

class NotificationTile extends StatelessWidget {
  final VoidCallback onTap;
  const NotificationTile({Key? key, required this.onTap}) : super(key: key);
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
                    children: const [
                      Text(
                          "You have A note Reply on wednesday 29th December From Abolarin Ayomide"),
                      Text("2 Days Ago")
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
