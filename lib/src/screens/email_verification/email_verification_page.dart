import 'package:flutter/material.dart';
import 'package:note/src/screens/employee_screens/employee_main/employee_main_page.dart';
import 'package:note/src/screens/employer_screens/employer_main/employer_main_page.dart';
import 'package:provider/provider.dart';

import '../../provider/util/user_type_provider.dart';
import '../../utils/constants.dart';
import '../../widget/default_button.dart';
import '../../widget/vertical_gap.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  var codeController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            const VerticalGap(gap: 150),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Enter The Code we sent to officialrrye@gmail.com",
                  style: heading2,
                )),
            const VerticalGap(gap: 30),
            Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: buildNameField()),
            const VerticalGap(gap: 30),
            Hero(
              tag: "button",
              child: DefaultButton(
                widget: Text(
                  "Next",
                  style: heading3White,
                ),
                onTap: () {
                  verifyUser();
                },
              ),
            ),
            const VerticalGap(gap: 30),
            Center(
              child: InkWell(
                onTap: () {},
                child: const Text(
                  "Did'nt Get Any Code? Resend Code",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  verifyUser() {
    var userType =
        Provider.of<UserTypeProvider>(context, listen: false).userType;

    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      debugPrint(userType.toString());
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: kAnimationDuration,
          pageBuilder: ((context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: Provider.of<UserTypeProvider>(context, listen: false)
                          .userType ==
                      0
                  ? const EmployeeMainPage()
                  : const EmployerMainPage(),
            );
          }),
        ),
      );
    }
  }

  Widget buildNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Enter Verification Code',
            style: layer2,
          ),
        ),
        const VerticalGap(gap: 10),
        TextFormField(
          style: heading1,
          controller: codeController,
          
          textAlign: TextAlign.center,
          maxLength: 4,
          validator: (value) {
            if (codeController.text.isEmpty) {
              return FIELD_REQUIRED_MSG;
            }
            return null;
          },
          onSaved: (String? value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: const [AutofillHints.countryCode],
          keyboardType: TextInputType.number,
          decoration:  InputDecoration(
            
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: "- - - -",
            hintStyle: heading1
          ),
        )
      ],
    );
  }
}
