import 'package:flutter/material.dart';
import 'package:note/src/provider/util/user_type_provider.dart';
import 'package:note/src/screens/launch_sign_up/launch_sign_up_page.dart';
import 'package:note/src/utils/constants.dart';
import 'package:note/src/widget/default_button.dart';
import 'package:note/src/widget/outline_button.dart';
import 'package:note/src/widget/vertical_gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose To sign Up As An Employee Or An Employer",
                  style: layer2,
                ),
              ),
              const VerticalGap(gap: 20),
              DefaultButton(
                  widget: Text(
                    "I Am An Employee",
                    style: heading3White,
                  ),
                  onTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool("isEmployer", false).then((value) {
                      Provider.of<UserTypeProvider>(context, listen: false)
                          .changeState(0);
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
                    });
                  }),
              const VerticalGap(gap: 20),
              OutlineButton(
                  widget: Text(
                    "I Am An Employer",
                    style: heading3Default,
                  ),
                  onTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool("isEmployer", true).then((value) {
                      Provider.of<UserTypeProvider>(context, listen: false)
                          .changeState(1);
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
                    });
                  }),
              const VerticalGap(gap: 20),
            ],
          ),
        ),
      ),
    );
  }
}
