import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/update_profile_api.dart';
import 'package:note/src/provider/database/profile_detail_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/processing_dialogue.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  File? imageUrl;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var value = Provider.of<ProfileDetailProvider>(context, listen: false);
    setState(() {
      emailController.text = value.model!.email ?? "";
      nameController.text = value.model!.fullName ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(
            color: Colors.red,
            widget: Text(
              "Delete Account",
              style: heading3White,
            ),
            onTap: () {},
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: heading3White,
        ),
        leading: customBackButton(context),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Consumer<ProfileDetailProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                height: 350.h,
                child: Stack(
                  children: [
                    value.model!.avatar == null
                        ? Container(
                            height: 300.h,
                            color: kGreyColor,
                          )
                        : Container(
                            height: 300.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(value.model!.avatar!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: kWhiteColor.withOpacity(0.0),
                                )),
                          ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          chooseImage();
                        },
                        child: Column(children: [
                          imageUrl == null
                              ? SizedBox(
                                  child: value.model!.avatar == null
                                      ? CircleAvatar(
                                          radius: 50.r,
                                          child: Text(value.model!.fullName
                                              .toString()[0]),
                                        )
                                      : CircleAvatar(
                                          radius: 50.r,
                                          backgroundImage: NetworkImage(
                                              value.model!.avatar!),
                                        ),
                                )
                              : CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage: FileImage(imageUrl!),
                                ),
                          Text(value.isLoggedIn
                              ? value.model!.fullName ?? ""
                              : "")
                        ]),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const VerticalGap(gap: 10),
                          buildNameField(),
                          const VerticalGap(gap: 20),
                          buildEmailField(),
                          const VerticalGap(gap: 100),
                          Hero(
                            tag: "button",
                            child: DefaultButton(
                                widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Save",
                                      style: heading3White,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  updateProfile();
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  chooseImage() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        imageUrl = File(result.paths.first!);
      });
    }
  }

  updateProfile() async {
    ProcessingDialog.showProcessingDialog(
      context: context,
      title: "Profile Update",
      subtitle: "hold on while we update your details",
    );
    if (imageUrl == null) {
      await UpdateProfileApi.updateProfile(fullName: nameController.text)
          .then((value) {
        Provider.of<ProfileDetailProvider>(context, listen: false).getDetails();
        ProcessingDialog.cancelDialog(context);
      });
    } else {
      await UpdateProfileApi.updateProfile(
              fullName: nameController.text, d: imageUrl!)
          .then((value) {
        Provider.of<ProfileDetailProvider>(context, listen: false).getDetails();
        ProcessingDialog.cancelDialog(context);
      });
    }
  }

  Widget buildNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Full Name',
            style: layer2,
          ),
        ),
        const VerticalGap(gap: 10),
        TextFormField(
          controller: nameController,
          validator: (value) {
            if (nameController.text.isEmpty) {
              return kNamelNullError;
            }
            return null;
          },
          onSaved: (String? value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: const [AutofillHints.name],
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: "Enter your full name",
            labelText: "Full name",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(
              Iconsax.user,
            ),
          ),
        )
      ],
    );
  }

  Widget buildEmailField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Email',
            style: layer2,
          ),
        ),
        const VerticalGap(gap: 10),
        TextFormField(
          controller: emailController,
          validator: (value) {
            if (emailController.text.isEmpty) {
              return kEmailNullError;
            } else if (!emailValidatorRegExp.hasMatch(emailController.text)) {
              return kInvalidEmailError;
            }
            return null;
          },
          onSaved: (String? value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: const [AutofillHints.email],
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "Enter your email",
            labelText: "Email",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(
              Iconsax.sms,
            ),
          ),
        )
      ],
    );
  }
}
