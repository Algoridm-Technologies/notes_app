import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/vertical_gap.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 350.h,
            child: Stack(
              children: [
                Container(
                  height: 300.h,
                  color: kGreyColor,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 50.r,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const Text('Colin Mark'),
                buildNameField(),
                const VerticalGap(gap: 50),
                DefaultButton(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save",
                          style: heading2White,
                        ),
                      ],
                    ),
                    onTap: () {})
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      mainAxisAlignment : MainAxisAlignment.start,
      children: const [
        Text('data'),
      ],
    );
  }
}
