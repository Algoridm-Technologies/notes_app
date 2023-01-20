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
  var nameController = TextEditingController();
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
            buildNameField(),
            const VerticalGap(gap: 30),
            Hero(
              tag: "button",
              child: DefaultButton(
                widget: Text(
                  "Next",
                  style: heading3White,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: kAnimationDuration,
                      pageBuilder: ((context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: Provider.of<UserTypeProvider>(context,
                                          listen: false)
                                      .userType ==
                                  0
                              ? const EmployeeMainPage()
                              : const EmployerMainPage(),
                        );
                      }),
                    ),
                  );
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
          controller: nameController,
          textAlign: TextAlign.center,
          maxLength: 4,
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
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: "- - - -",
          ),
        )
      ],
    );
  }
}