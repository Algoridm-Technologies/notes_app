import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/utils/constants.dart';

import '../../widget/vertical_gap.dart';

class AddStaffsPage extends StatefulWidget {
  const AddStaffsPage({Key? key}) : super(key: key);

  @override
  State<AddStaffsPage> createState() => _AddStaffsPageState();
}

class _AddStaffsPageState extends State<AddStaffsPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Staff'),
          centerTitle: true,
        ),
        body: ListView(
          padding: screenPadding,
          children: [
            const Text("Add Staff to join the company"),
            const VerticalGap(gap: 30),
            buildNameField(),
            const VerticalGap(gap: 10),
            buildEmailField(),
            const VerticalGap(gap: 10),
            buildFacilityField(),
          ],
        ));
  }

  Widget buildFacilityField() {
    return const Text("");
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
