import 'package:flutter/material.dart';
import 'package:note/src/screens/launch_sign_up/launch_sign_up_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/outline_button.dart';
import 'package:note/src/widget/vertical_gap.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);
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
                  "I Am?",
                  style: heading,
                ),
              ),
              const VerticalGap(gap: 20),
              Text(
                "Consequat et laboris do aliqua amet aliqua esse commodo reprehenderit excepteur qui anim.",
                style: layer2,
              ),
              const VerticalGap(gap: 20),
              DefaultButton(
                  widget: Text(
                    "I am a Staff",
                    style: heading3White,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: kAnimationDuration,
                        pageBuilder: ((context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: const LaunchSignUpPage(),
                          );
                        }),
                      ),
                    );
                  }),
              const VerticalGap(gap: 20),
              OutlineButton(
                  widget: Text(
                    "I am an Admin",
                    style: heading3Default,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: kAnimationDuration,
                        pageBuilder: ((context, animation, _) {
                          return FadeTransition(
                            opacity: animation,
                            child: const LaunchSignUpPage(),
                          );
                        }),
                      ),
                    );
                  }),
              const VerticalGap(gap: 20),
            ],
          ),
        ),
      ),
    );
  }
}
