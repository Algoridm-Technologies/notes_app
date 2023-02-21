import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/api/register_user_api.dart';
import 'package:note/src/screens/login/login_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/custom_snackbar.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/processing_dialogue.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../email_verification/email_verification_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool check = false;
  bool isShowing = true;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
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
                "Sign Up",
                style: heading,
              ),
              Text(
                "Sunt dolor ea consectetur proident nisi cupidatat commodo velit anim dolor laborum.",
                style: layer2,
              ),
              const VerticalGap(gap: 30),
              buildNameField(),
              const VerticalGap(gap: 10),
              buildEmailField(),
              const VerticalGap(gap: 10),
              buildPasswordField(),
              const VerticalGap(gap: 50),
              Hero(
                tag: "button",
                child: DefaultButton(
                  widget: Text(
                    "Sign Up",
                    style: heading3White,
                  ),
                  onTap: () {
                    registerUser();
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
                                child: const LoginPage(),
                              );
                            }),
                          ),
                        );
                      },
                      child: const Text("Have An Account? Log in"))),
            ],
          ),
        ),
      ),
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
            hintText: "Enter your Full Name",
            labelText: "Full Name",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(
              Iconsax.user,
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
            } else if (!passwordController.text.contains(RegExp(
                r"((?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*()_+~?])(?=.*[0-9]))"))) {
              return kInvalidPasswordError;
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

  registerUser() async {
    var prefs = await SharedPreferences.getInstance();

    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ProcessingDialog.showProcessingDialog(
          context: context, title: "New User", subtitle: "Creating New User");

      await RegisterUserApi.registerUser(
              fullName: nameController.text,
              email: emailController.text,
              isEmployer: prefs.getBool('isEmployer') ?? false,
              password: passwordController.text)
          .then((value) {
        ProcessingDialog.cancelDialog(context);
        // print(value['success']);
        if (jsonDecode(value)["email"] != null) {
          CustomSnackBar.showSnackbar(
            backgroundColor: kErrorColor1,
              context: context, title: jsonDecode(value)["email"][0]);
        }
        if (jsonDecode(value)["success"] != null) {
          CustomSnackBar.showSnackbar(
              context: context, title: jsonDecode(value)["success"]);
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: kAnimationDuration,
              pageBuilder: ((context, animation, _) {
                return FadeTransition(
                  opacity: animation,
                  child: EmailVerificationPage(
                    email: emailController.text,
                    source: "register",
                  ),
                );
              }),
            ),
          );
        }
      });
    }
  }
}
