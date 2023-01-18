import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/screens/new_password/new_password_page.dart';

import '../../utils/constants.dart';
import '../../widget/default_button.dart';
import '../../widget/vertical_gap.dart';

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgottenPasswordPage> createState() => _ForgottenPasswordPageState();
}

class _ForgottenPasswordPageState extends State<ForgottenPasswordPage> {
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            const VerticalGap(gap: 50),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Forgotten Password",
                style: heading1,
              ),
            ),
            const VerticalGap(gap: 20),
            Text(
              "Consequat et laboris do aliqua amet aliqua esse commodo reprehenderit excepteur qui anim.",
              style: layer2,
            ),
            const VerticalGap(gap: 30),
            buildNameField(),
            const VerticalGap(gap: 30),
            Hero(
              tag: "button",
              child: DefaultButton(
                widget: Text(
                  "Continue",
                  style: heading3White,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: kAnimationDuration,
                      pageBuilder: ((context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: const NewPasswordPage(),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
            const VerticalGap(gap: 30),
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
            'Enter Email',
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
