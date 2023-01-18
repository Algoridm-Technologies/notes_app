import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/vertical_gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  bool check = false;
  bool isShowing = false;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: screenPadding,
        children: [
          const VerticalGap(gap: 30),
          const Text("Sign In"),
          const Text("Sign In"),
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
              const Text("Forgotten Password?")
            ],
          ),
          const VerticalGap(gap: 50),
          DefaultButton(
            widget: Text(
              "Sign In",
              style: heading2White,
            ),
            onTap: () {},
          ),
          VerticalGap(gap: 30),
          const Center(child: Text("Dont Have An Account? Sign Up")),
          
        ],
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
          autofillHints: const [AutofillHints.email],
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "Enter your password",
            labelText: "Password",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(
              Iconsax.sms,
            ),
            // suffix: 
          ),
        )
      ],
    );
  }
}
