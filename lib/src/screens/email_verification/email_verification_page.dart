import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note/src/api/check_password_reset_api.dart';
import 'package:note/src/api/resend_email_otp_api.dart';
import 'package:note/src/api/verify_email_api.dart';
import 'package:note/src/screens/new_password/new_password_page.dart';
import 'package:note/src/widget/custom_snackbar.dart';
import 'package:note/src/widget/processing_dialogue.dart';

import '../../utils/constants.dart';
import '../../widget/default_button.dart';
import '../../widget/vertical_gap.dart';
import '../login/login_page.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;
  final String source;
  const EmailVerificationPage(
      {Key? key, required this.email, required this.source})
      : super(key: key);

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
                  "Enter The Code we sent to ${widget.email} ",
                  textAlign: TextAlign.center,
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
                  if (widget.source == "reset") {
                    checkResetOtp();
                  } else {
                    verifyUser();
                  }
                },
              ),
            ),
            const VerticalGap(gap: 30),
            Center(
              child: InkWell(
                onTap: () {
                  resendEmailOtp();
                },
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

  verifyUser() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ProcessingDialog.showProcessingDialog(
          context: context, title: "title", subtitle: "subtitle");

      await VerifyEmailApi.verifyEmail(
              email: widget.email, otp: codeController.text)
          .then((value) {
        print(value);
        ProcessingDialog.cancelDialog(context);

        if (jsonDecode(value)['error'] != null) {
          CustomSnackBar.showSnackbar(
              context: context, title: jsonDecode(value)['error']);
        }
        if (jsonDecode(value)['success'] != null) {
          CustomSnackBar.showSnackbar(
              context: context, title: jsonDecode(value)['success']);
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: kAnimationDuration,
              pageBuilder: ((context, animation, _) {
                return FadeTransition(
                    opacity: animation, child: const LoginPage());
              }),
            ),
          );
        }
      });
    }
  }

  checkResetOtp() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ProcessingDialog.showProcessingDialog(
          context: context, title: "title", subtitle: "subtitle");

      await CheckPasswordResetOtpApi.checkPasswordResetOtp(
              email: widget.email, otp: codeController.text)
          .then((value) {
        ProcessingDialog.cancelDialog(context);

        if (jsonDecode(value)['error'] != null) {
          CustomSnackBar.showSnackbar(
              context: context, title: jsonDecode(value)['error']);
        }
        if (jsonDecode(value)['success'] != null) {
          CustomSnackBar.showSnackbar(
              context: context, title: jsonDecode(value)['success']);
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: kAnimationDuration,
              pageBuilder: ((context, animation, _) {
                return FadeTransition(
                    opacity: animation, child: const NewPasswordPage());
              }),
            ),
          );
        }
      });
    }
  }

  resendEmailOtp() async {
    ProcessingDialog.showProcessingDialog(
        context: context, title: "title", subtitle: "subtitle");

    await ResendEmailVerificationApi.resendEmailVerification(
            email: widget.email)
        .then((value) {
      ProcessingDialog.cancelDialog(context);

      if (jsonDecode(value)['error'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['error']);
      }
      if (jsonDecode(value)['success'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['success']);
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: kAnimationDuration,
            pageBuilder: ((context, animation, _) {
              return FadeTransition(
                  opacity: animation, child: const LoginPage());
            }),
          ),
        );
      }
    });
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
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: "- - - -",
              hintStyle: heading1),
        )
      ],
    );
  }
}
