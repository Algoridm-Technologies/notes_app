import 'package:flutter/material.dart';
import 'package:note/src/provider/authentification/user_auth.dart';
import 'package:note/src/provider/navigation/employee_navigation_provider.dart';
import 'package:note/src/provider/navigation/employer_navigation_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:note/src/provider/util/tab_provider.dart';
import 'package:note/src/provider/util/user_type_provider.dart';
import 'package:note/src/screens/launch/launch_page.dart';
import 'package:note/src/screens/login/login_page.dart';
import 'package:note/src/style/style.dart';
import 'package:note/src/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  var prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token") ?? "";
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String token;
  const MyApp({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserTypeProvider()),
        Provider(create: (_) => UserAuthProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => CheckProvider()),
        ChangeNotifierProvider(create: (_) => EmployerNavigationProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeNavigationProvider()),
        ChangeNotifierProvider(create: (_) => SetStateProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            title: appName,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: token == "" ? const LaunchPage() : const LoginPage(),
            // home: TestPage(),
          );
        },
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
      ),
    );
  }
}
