import 'package:flutter/material.dart';
import 'package:note/src/provider/navigation/navigation_provider.dart';
import 'package:note/src/provider/util/check_provider.dart';
import 'package:note/src/provider/util/setstate_provider.dart';
import 'package:note/src/screens/launch/launch_page.dart';
import 'package:note/src/style/style.dart';
import 'package:note/src/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SetStateProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            title: appName,
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: const LaunchPage(),
          );
        },
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
      ),
    );
  }
}
