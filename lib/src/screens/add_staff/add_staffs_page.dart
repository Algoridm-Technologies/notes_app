import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/add_user_api.dart';
import 'package:note/src/provider/database/facility_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_snackbar.dart';
import 'package:note/src/widget/processing_dialogue.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/success_with_field_dialogue.dart';
import 'package:provider/provider.dart';

import '../../widget/vertical_gap.dart';

class AddStaffsPage extends StatefulWidget {
  const AddStaffsPage({Key? key}) : super(key: key);

  @override
  State<AddStaffsPage> createState() => _AddStaffsPageState();
}

class _AddStaffsPageState extends State<AddStaffsPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String selectedFacility = "Select Facility";
  String selectedFacilityId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Staff'),
          leading: customBackButton(context),
          centerTitle: true,
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            padding: screenPadding,
            children: [
              const Text("Add Staff to join the company"),
              const VerticalGap(gap: 30),
              buildNameField(),
              const VerticalGap(gap: 10),
              buildEmailField(),
              const VerticalGap(gap: 10),
              buildFacilityField(),
              const VerticalGap(gap: 50),
              DefaultButton(
                  widget: Text(
                    "Add Staff",
                    style: heading3White,
                  ),
                  onTap: () {
                    addStaff();
                  }),
            ],
          ),
        ));
  }

  Widget buildFacilityField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Facility',
            style: layer2,
          ),
        ),
        const VerticalGap(gap: 10),
        InkWell(
          onTap: () {
            showDialogue();
          },
          child: Container(
              height: 52.h,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.category,
                    size: 24.r,
                  ),
                  const HorizontalGap(gap: 10),
                  Text(selectedFacility),
                  const Spacer(),
                  Icon(
                    Iconsax.arrow_down_1,
                    size: 24.r,
                  ),
                ],
              )),
        ),
      ],
    );
  }

  addStaff() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ProcessingDialog.showProcessingDialog(
          context: context,
          title: "Adding Staff",
          subtitle: "Adding new staff to the database");
      await AddUserApi.addUser(
              fullName: nameController.text,
              email: emailController.text,
              facilityId: selectedFacilityId)
          .then((value) {
        print(value);
        ProcessingDialog.cancelDialog(context);
        if (jsonDecode(value)['success'] != null &&
            jsonDecode(value)['data'] != null) {
          var password = jsonDecode(value)['data']['password'];
          SuccessWithFieldDialog.showSuccessDialog(
              context: context,
              title: "Staff Added Successfully",
              subtitle:
                  "Staff has been successfully added to the staff list and the staff password has been successfully generated,",
              password: password);
          CustomSnackBar.showSnackbar(
              context: context, title: jsonDecode(value)['success']);
        }
        if (jsonDecode(value)['email'] != null) {
          CustomSnackBar.showSnackbar(
              context: context, title: jsonDecode(value)['email'][0]);
        }
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
        SizedBox(
          height: 52.h,
          child: TextFormField(
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
            decoration: InputDecoration(
              hintText: "Enter your full name",
              labelText: "Full name",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(
                Iconsax.user,
                size: 24.r,
              ),
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
        SizedBox(
          height: 52.h,
          child: TextFormField(
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
            decoration: InputDecoration(
              hintText: "Enter your email",
              labelText: "Email",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: Icon(
                Iconsax.sms,
                size: 24.r,
              ),
            ),
          ),
        )
      ],
    );
  }

  showDialogue() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: const Text("Choose Facility"),
            content: SizedBox(
              height: 300.h,
              width: 200.w,
              child: Consumer<FacilityProvider>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? const CupertinoActivityIndicator()
                      : ListView.builder(
                          itemCount: value.list.length,
                          itemBuilder: (context, index) {
                            var data = value.list[index]!;
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedFacility = data.title ?? "";
                                  selectedFacilityId = data.id ?? "";
                                });
                                Navigator.pop(context);
                              },
                              title: Text(data.title ?? ""),
                            );
                          },
                        );
                },
              ),
            ),
          );
        });
  }
}
