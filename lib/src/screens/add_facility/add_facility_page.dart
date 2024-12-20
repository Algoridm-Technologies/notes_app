import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/src/api/add_facility_api.dart';
import 'package:note/src/provider/database/facility_provider.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_back_button.dart';
import 'package:note/src/widget/custom_snackbar.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:provider/provider.dart';

import '../../widget/processing_dialogue.dart';
import '../../widget/vertical_gap.dart';

class AddFacilityPage extends StatefulWidget {
  const AddFacilityPage({Key? key}) : super(key: key);

  @override
  State<AddFacilityPage> createState() => _AddFacilityPageState();
}

class _AddFacilityPageState extends State<AddFacilityPage> {
  var nameController = TextEditingController();
  var locationController = TextEditingController();
  File? imagePath;

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Facility'),
          leading: customBackButton(context),
          centerTitle: true,
        ),
        body: ListView(
            padding: screenPadding,
          children: [
            Column(
            
              children: [
                const Text("Add Facility to join the company"),
                const VerticalGap(gap: 30),
                buildNameField(),
                const VerticalGap(gap: 10),
                buildLocationField(),
                const VerticalGap(gap: 10),
                buildImageField(),
                const VerticalGap(gap: 100),
                DefaultButton(
                    widget: Text(
                      "Add Facility",
                      style: heading3White,
                    ),
                    onTap: () {
                      if(nameController.text.isEmpty){
                              CustomSnackBar.showSnackbar(
            context: context, title: "enter the facility name");
                        return;
                      }
                        if(locationController.text.isEmpty){
                              CustomSnackBar.showSnackbar(
            context: context, title: "enter the facility location");
                        return;
                      }
                        if(imagePath==null){
                              CustomSnackBar.showSnackbar(
            context: context, title: "select an image");
                        return;
                      }

                      updateProfile();
                    }),
              ],
            ),
          ],
        ));
  }

  updateProfile() async {
    ProcessingDialog.showProcessingDialog(
        context: context,
        title: "Add facility...",
        subtitle: "Just hold on a second trying to make your perfect Dashboard with your Chosen Information");
    await AddFacilityApi.addFacility(
            name: nameController.text,
            location: locationController.text,
            d: imagePath!)
        .then((value) {
      Provider.of<FacilityProvider>(context, listen: false).getFacility();
      ProcessingDialog.cancelDialog(context);
     
      if (jsonDecode(value)['success'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['success']);
      }else{
           CustomSnackBar.showSnackbar(
            backgroundColor: kErrorColor1,
            context: context, title: "Something went wrong");
      }
    });
  }

  Widget buildImageField() {
    return Column(
      children: [
        Container(
            height: 120.h,
            width: 120.h,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: imagePath == null
                      ? CircleAvatar(
                          radius: double.infinity,
                          backgroundColor: kGreyColor.withOpacity(0.2),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: kGreyColor,
                            size: 50.sp,
                          ),
                        )
                      : CircleAvatar(
                          radius: double.infinity,
                          backgroundColor: kGreyColor.withOpacity(0.2),
                          backgroundImage: FileImage(
                            imagePath!,
                          ),
                        ),
                ),
              ],
            )),
        const VerticalGap(gap: 10),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'upload Facility Image',
            style: layer1,
          ),
        ),
      ],
    );
  }

  Widget buildNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Facility Name',
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
            hintText: "Enter your facility name",
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(),
            labelText: "Facility name",
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        )
      ],
    );
  }

  Widget buildLocationField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Facility Location',
            style: layer2,
          ),
        ),
        const VerticalGap(gap: 10),
        TextFormField(
          controller: locationController,
          validator: (value) {
            if (locationController.text.isEmpty) {
              return FIELD_REQUIRED_MSG;
            }
            return null;
          },
          onSaved: (String? value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: const [AutofillHints.location],
          keyboardType: TextInputType.streetAddress,
          decoration: const InputDecoration(
            hintText: "Enter your location",
            labelText: "Location",
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        )
      ],
    );
  }

  pickImage() async {
    var result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        imagePath = File(result.paths.first!);
      });
    }
  }
}
