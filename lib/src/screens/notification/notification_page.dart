import 'package:flutter/material.dart';
import 'package:note/src/screens/notification/components/notification_tile.dart';
import 'package:note/src/widget/custom_back_button.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return NotificationTile(onTap: () {});
        },
      ),
    );
  }
}
