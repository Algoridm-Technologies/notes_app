import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/google_auth_api.dart';
import 'package:note/src/screens/login/login_page.dart';
import 'package:note/src/screens/register/register_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/vertical_gap.dart';

import '../../widget/custom_snackbar.dart';
import '../../widget/processing_dialogue.dart';

class LaunchSignUpPage extends StatefulWidget {
  const LaunchSignUpPage({Key? key}) : super(key: key);

  @override
  State<LaunchSignUpPage> createState() => _LaunchSignUpPageState();
}

class _LaunchSignUpPageState extends State<LaunchSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up",
                  style: heading,
                ),
              ),
              const VerticalGap(gap: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Not A Member On Note App? Sign up Here to get Started",
                  style: layer2,
                ),
              ),
              const VerticalGap(gap: 30),
              // OutlineButton(
              //     widget: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset("assets/icons/google.svg"),
              //         const HorizontalGap(gap: 10),
              //         Text(
              //           "Sign up with google",
              //           style: heading3Default,
              //         ),
              //       ],
              //     ),
              //     onTap: () {
              //       googleSign();
              //     }),
              const VerticalGap(gap: 30),
              DefaultButton(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.sms,
                        color: kWhiteColor,
                      ),
                      const HorizontalGap(gap: 10),
                      Text(
                        "Sign up with Email",
                        style: heading3White,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: kAnimationDuration,
                        pageBuilder: ((context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: const RegisterPage(),
                          );
                        }),
                      ),
                    );
                  }),
              const VerticalGap(gap: 20),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: kAnimationDuration,
                        pageBuilder: ((context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: const LoginPage(),
                          );
                        }),
                      ),
                    );
                  },
                  child: const Text("Have An Account Already? Log in"))
            ],
          ),
        ),
      ),
    );
  }

  googleSign() async {
    ProcessingDialog.showProcessingDialog(
        context: context, title: "title", subtitle: "subtitle");

    await GoogleAuthApi.googleAuthApi().then((value) {
      ProcessingDialog.cancelDialog(context);

      if (jsonDecode(value)['error'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['error']);
      }
      if (jsonDecode(value)['password'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['password'][0]);
      }
      if (jsonDecode(value)['success'] != null) {
        CustomSnackBar.showSnackbar(
            context: context, title: jsonDecode(value)['success']);
        // Navigator.of(context).push(
        //   PageRouteBuilder(
        //     transitionDuration: kAnimationDuration,
        //     pageBuilder: ((context, animation, _) {
        //       return FadeTransition(
        //         opacity: animation,
        //         child: EmailVerificationPage(
        //           email: emailController.text,
        //           source: "reset",
        //         ),
        //       );
        //     }),
        //   ),
        // );
      }
    });
  }
}
