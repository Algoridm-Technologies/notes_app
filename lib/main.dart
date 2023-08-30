import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:note/src/provider/authentification/user_auth.dart';
import 'package:note/src/provider/database/access_provider.dart';
import 'package:note/src/provider/database/current_facility_provider.dart';
import 'package:note/src/provider/database/employee_and_note_provider.dart';
import 'package:note/src/provider/database/employee_note_provider.dart';
import 'package:note/src/provider/database/facility_provider.dart';
import 'package:note/src/provider/database/note_by_employee_provider.dart';
import 'package:note/src/provider/database/note_detail_employee_provider.dart';
import 'package:note/src/provider/database/note_detail_employer_provider.dart';
import 'package:note/src/provider/database/notification_provider.dart';
import 'package:note/src/provider/database/profile_detail_provider.dart';
import 'package:note/src/provider/navigation/employee_navigation_provider.dart';
import 'package:note/src/provider/navigation/employer_navigation_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/provider/util/search_provider.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:note/src/provider/util/tab_provider.dart';
import 'package:note/src/provider/util/user_type_provider.dart';
import 'package:note/src/screens/launch/launch_page.dart';
import 'package:note/src/screens/wrapper/auth_wrapper.dart';
import 'package:note/src/style/style.dart';
import 'package:note/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isEmployer = false;
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token") ?? "";

  if (token != "") {
    Map<String, dynamic> data = Jwt.parseJwt(token);

    isEmployer = data["is_employer"];
    prefs.setBool('isEmployer', isEmployer);
  }

  runApp(MyApp(token: token, isEmployer: isEmployer));
}

class MyApp extends StatelessWidget {
  final String token;
  final bool isEmployer;
  const MyApp({super.key, required this.token, required this.isEmployer});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserTypeProvider()),
        Provider(create: (_) => UserAuthProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => CheckProvider()),
        ChangeNotifierProvider(create: (_) => EmployerNavigationProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeNavigationProvider()),
        ChangeNotifierProvider(create: (_) => SetStateProvider()),
        ChangeNotifierProvider(create: (_) => AccessProvider()),
        ChangeNotifierProvider(create: (_) => ProfileDetailProvider()),
        ChangeNotifierProvider(create: (_) => FacilityProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeAndNoteProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeNoteProvider()),
        ChangeNotifierProvider(create: (_) => NoteDetailEmployeeProvider()),
        ChangeNotifierProvider(create: (_) => NoteDetailEmployerProvider()),
        ChangeNotifierProvider(create: (_) => NoteByEmployeeProvider()),
        ChangeNotifierProvider(create: (_) => CurrentFacilityProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            title: appName,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: token == ""
                ? const LaunchPage()
                : AuthWrapper(
                    isEmployer: isEmployer,
                  ),
          );
        },
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
      ),
    );
  }
}
