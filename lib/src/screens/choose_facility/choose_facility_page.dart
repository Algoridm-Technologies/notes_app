import 'package:flutter/material.dart';
import 'package:note/src/api/select_facility_api.dart';
import 'package:note/src/provider/database/facility_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/screens/choose_facility/components/facility_list.dart';
import 'package:note/src/screens/employee_screens/employee_main/employee_main_page.dart';
import 'package:note/src/utils/refresh_token.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/util/user_type_provider.dart';
import '../../utils/constants.dart';
import '../../widget/default_button.dart';
import '../../widget/vertical_gap.dart';
import '../employer_screens/employer_main/employer_main_page.dart';

class ChooseFacilityPage extends StatefulWidget {
  const ChooseFacilityPage({Key? key}) : super(key: key);

  @override
  State<ChooseFacilityPage> createState() => _ChooseFacilityPageState();
}

class _ChooseFacilityPageState extends State<ChooseFacilityPage> {
  var emailController = TextEditingController();
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
                "Choose Facility",
                style: heading1,
              ),
            ),
            const VerticalGap(gap: 20),
            Text(
              "Consequat et laboris do aliqua amet aliqua esse commodo reprehenderit excepteur qui anim.",
              style: layer2,
            ),
            const VerticalGap(gap: 30),
            const FacilityList(),
            const VerticalGap(gap: 30),
            Hero(
              tag: "button",
              child: DefaultButton(
                widget: Text(
                  "Next",
                  style: heading3White,
                ),
                onTap: () async {
                  var v = await SharedPreferences.getInstance();
                  var isEmplyer = v.getBool('is_employer') ?? false;
                  if (Provider.of<CheckProvider>(context, listen: false)
                          .selected ==
                      -1) {
                    return;
                  }
                  var id = Provider.of<FacilityProvider>(context, listen: false)
                      .list[Provider.of<CheckProvider>(context, listen: false)
                          .selected]!
                      .id;
                  await RefreshToken.refreshToken().then((value) async {
                    await SelectFacilityApi.selectFacility(id: id!)
                        .then((value) {
                      print(value);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: kAnimationDuration,
                          pageBuilder: ((context, animation, _) {
                            return FadeTransition(
                                opacity: animation,
                                child: isEmplyer
                                    ? EmployerMainPage()
                                    : EmployeeMainPage());
                          }),
                        ),
                      );
                    });
                  });
                },
              ),
            ),
            const VerticalGap(gap: 30),
          ],
        ),
      ),
    );
  }
}
