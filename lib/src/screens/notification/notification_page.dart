import 'package:flutter/material.dart';
import 'package:note/src/provider/database/notification_provider.dart';
import 'package:note/src/screens/notification/components/notification_tile.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:provider/provider.dart';

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
      body: RefreshIndicator(
        onRefresh: () async {
          await RefreshToken.refreshToken().then((value) {
            Provider.of<NotificationProvider>(context, listen: false)
                .getFacility();
          });
        },
        child: Consumer<NotificationProvider>(
          builder: (context, value, child) {
            return value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : value.list.isEmpty
                    ? const Center(child: Text("No item"))
                    : ListView.builder(
                        itemCount: value.list.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NotificationTile(
                            model: value.list[index]!,
                            onTap: () {},
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
