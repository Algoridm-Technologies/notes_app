import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/login_user_api.dart';
import 'package:note/src/provider/util/user_type_provider.dart';
import 'package:note/src/screens/forgotten_password/forgotten_password_page.dart';
import 'package:note/src/screens/register/register_page.dart';
import 'package:note/src/screens/wrapper/facility_wrapper.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_snackbar.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/processing_dialogue.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/resend_email_otp_api.dart';
import '../email_verification/email_verification_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool check = false;
  bool isShowing = true;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: AutofillGroup(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: screenPadding,
            children: [
              const VerticalGap(gap: 100),
              Text(
                "Sign In",
                style: heading,
              ),
              Text(
                "Consectetur esse dolore magna ut proident.Amet ad velit Lorem quis.",
                style: layer2,
              ),
              const VerticalGap(gap: 20),
              buildEmailField(),
              const VerticalGap(gap: 30),
              buildPasswordField(),
              const VerticalGap(gap: 30),
              Row(
                children: [
                  Checkbox(
                      activeColor: kAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: check,
                      onChanged: (v) {
                        setState(() {
                          check = !check;
                        });
                      }),
                  const Text("Remember Me"),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: kAnimationDuration,
                            pageBuilder: ((context, animation, _) {
                              return FadeTransition(
                                opacity: animation,
                                child: const ForgottenPasswordPage(),
                              );
                            }),
                          ),
                        );
                      },
                      child: const Text("Forgotten Password?"))
                ],
              ),
              const VerticalGap(gap: 50),
              Hero(
                tag: "button",
                child: DefaultButton(
                  widget: Text(
                    "Sign In",
                    style: heading3White,
                  ),
                  onTap: () {
                    loginUser();
                    // AddingDialog.showAddingDialog(context: context, title: "Processing", subtitle: "Voluptate voluptate labore duis mollit cupidatat.");
                  },
                ),
              ),
              const VerticalGap(gap: 30),
              Center(
                  child: InkWell(
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
                      },
                      child: const Text("Don't Have An Account? Sign Up"))),
            ],
          ),
        ),
      ),
    );
  }

  loginUser() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ProcessingDialog.showProcessingDialog(
          context: context, title: "Sign in", subtitle: "Signing in user");
      await LoginUserApi.loginUserApi(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) async {
        ProcessingDialog.cancelDialog(context);
        print(value);

        if (value == "Error") {
          CustomSnackBar.showSnackbar(
              backgroundColor: kErrorColor1,
              context: context,
              title: "Something went wrong");
          return;
        }

        if (jsonDecode(value)['error'] == "Invalid credentials") {
          CustomSnackBar.showSnackbar(
              backgroundColor: kErrorColor1,
              context: context,
              title: jsonDecode(value)['error']);
          return;
        }
        if (jsonDecode(value)['error'] == "You must verify your email first") {
          CustomSnackBar.showSnackbar(
              backgroundColor: kErrorColor1,
              context: context,
              title: jsonDecode(value)['error']);
          await resendEmailOtp();
        }

        var prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> data = Jwt.parseJwt(jsonDecode(value)['access']);
        print(data);
        var selectedUser =
            Provider.of<UserTypeProvider>(context, listen: false).userType == 0
                ? true
                : false;
        var loginUser = data['is_employer'];
        // print(selectedUser);
        // print(data['is_employer']);
        if (selectedUser == loginUser) {
          CustomSnackBar.showSnackbar(
              context: context, title: "You can't login as this type of user");
          return;
        }
        print(selectedUser == loginUser);
        // return;
        prefs.setString("refresh", jsonDecode(value)['refresh']);

        prefs.setString("token", jsonDecode(value)['access']).then((_) {
          if (data["is_employer"] == true) {
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  transitionDuration: kAnimationDuration,
                  pageBuilder: ((context, animation, _) {
                    return FadeTransition(
                      opacity: animation,
                      child: const FacilityWrapper(),
                    );
                  }),
                ),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  transitionDuration: kAnimationDuration,
                  pageBuilder: ((context, animation, _) {
                    return FadeTransition(
                      opacity: animation,
                      child: const FacilityWrapper(),
                    );
                  }),
                ),
                (Route<dynamic> route) => false);
          }
        });
      });
    }
  }

  resendEmailOtp() async {
    ProcessingDialog.showProcessingDialog(
        context: context, title: "Otp", subtitle: "resending otp");

    await ResendEmailVerificationApi.resendEmailVerification(
            email: emailController.text)
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
                  opacity: animation,
                  child: EmailVerificationPage(
                    email: emailController.text,
                    source: "register",
                  ));
            }),
          ),
        );
      }
    });
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
            }
            return null;
          },
          onSaved: (String? value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: const [AutofillHints.password],
          keyboardType: TextInputType.visiblePassword,
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
}
