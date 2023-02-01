import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/set_new_password_api.dart';
import 'package:note/src/widget/success_dialogue.dart';

import '../../utils/constants.dart';
import '../../widget/custom_snackbar.dart';
import '../../widget/default_button.dart';
import '../../widget/processing_dialogue.dart';
import '../../widget/vertical_gap.dart';
import '../login/login_page.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isShowing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            const VerticalGap(gap: 100),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter New Password",
                style: heading1,
              ),
            ),
            const VerticalGap(gap: 20),
            Text(
              "Consequat et laboris do aliqua amet aliqua esse commodo reprehenderit excepteur qui anim.",
              style: layer2,
            ),
            const VerticalGap(gap: 30),
            buildPasswordField(),
            const VerticalGap(gap: 30),
            buildConfirmPasswordField(),
            const VerticalGap(gap: 50),
            Hero(
              tag: "button",
              child: DefaultButton(
                widget: Text(
                  "Reset Password",
                  style: heading3White,
                ),
                onTap: () {
                  setNewPassword();
                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //     transitionDuration: kAnimationDuration,
                  //     pageBuilder: ((context, animation, _) {
                  //       return FadeTransition(
                  //         opacity: animation,
                  //         child: const MainPage(),
                  //       );
                  //     }),
                  //   ),
                  // );
                },
              ),
            ),
            const VerticalGap(gap: 30),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Password',
            style: layer2,
          ),
        ),
        const VerticalGap(gap: 10),
        TextFormField(
          controller: passwordController,
          obscureText: isShowing,
          validator: (value) {
            if (passwordController.text.isEmpty) {
              return kPassNullError;
            } else if (passwordController.text.length < 8) {
              return kShortPassError;
            } else if (!passwordController.text.contains(RegExp(
                r"((?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*()_+~?])(?=.*[0-9]))"))) {
              return kInvalidPasswordError;
            }
            return null;
          },
          onSaved: (String? value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: const [AutofillHints.email],
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter your password",
            labelText: "Password",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(
              Iconsax.lock_1,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isShowing = !isShowing;
                });
              },
              icon: const Icon(
                Iconsax.eye,
              ),
            ),
            // suffix:
          ),
        )
      ],
    );
  }

  Widget buildConfirmPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Re-Enter Password',
            style: layer2,
          ),
        ),
        const VerticalGap(gap: 10),
        TextFormField(
          controller: confirmPasswordController,
          obscureText: isShowing,
          validator: (value) {
            if (confirmPasswordController.text.isEmpty) {
              return kPassNullError;
            } else if (confirmPasswordController.text.length < 8) {
              return kShortPassError;
            } else if (passwordController.text !=
                confirmPasswordController.text) {
              return kMatchPassError;
            } else if (!confirmPasswordController.text.contains(RegExp(
                r"((?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*()_+~?])(?=.*[0-9]))"))) {
              return kInvalidPasswordError;
            }
            return null;
          },
          onSaved: (String? value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: const [AutofillHints.email],
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Enter your password",
            labelText: "Password",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(
              Iconsax.lock_1,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isShowing = !isShowing;
                });
              },
              icon: const Icon(
                Iconsax.eye,
              ),
            ),
            // suffix:
          ),
        )
      ],
    );
  }

  setNewPassword() async {
    ProcessingDialog.showProcessingDialog(
        context: context, title: "title", subtitle: "subtitle");

    await SetNewPasswordApi.setNewPassword(
      password: confirmPasswordController.text,
    ).then((value) {
      ProcessingDialog.cancelDialog(context);
      print(value);

      if (jsonDecode(value)['error'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['error']);
      }
      if (jsonDecode(value)['success'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['success']);
        SuccessDialog.showSuccessDialog(
          context: context,
          title: "title",
          subtitle: "subtitle",
        );
        Future.delayed(const Duration(seconds: 2)).then((value) {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: kAnimationDuration,
              pageBuilder: ((context, animation, _) {
                return FadeTransition(
                    opacity: animation, child: const LoginPage());
              }),
            ),
          );
        });
      }
    });
  }
}
