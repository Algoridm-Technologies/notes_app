import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:note/src/screens/login/login_page.dart';
import 'package:note/src/screens/register/register_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/horizontal_gap.dart';
import 'package:note/src/widget/outline_button.dart';
import 'package:note/src/widget/vertical_gap.dart';

class LaunchSignUpPage extends StatelessWidget {
  const LaunchSignUpPage({Key? key}) : super(key: key);
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
              Text(
                "Consequat et laboris do aliqua amet aliqua esse commodo reprehenderit excepteur qui anim.",
                style: layer2,
              ),
              const VerticalGap(gap: 10),
              OutlineButton(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/google.svg"),
                      const HorizontalGap(gap: 10),
                      Text(
                        "Sign up with google",
                        style: heading3Default,
                      ),
                    ],
                  ),
                  onTap: () {}),
              const VerticalGap(gap: 10),
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
              const VerticalGap(gap: 10),
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
}
