import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/src/utils/constants.dart';

var appTheme = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  useMaterial3: true,
  splashColor: kPrimaryColor1.withOpacity(0.2),
  hoverColor: kPrimaryColor1.withOpacity(0.2),
  backgroundColor: kWhiteColor,
  scaffoldBackgroundColor: kWhiteColor,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kPrimaryColor1,
  ),
  primaryColor: kPrimaryColor1,
  primaryColorDark: kPrimaryColor1,
  primaryColorLight: kPrimaryColor1,
  appBarTheme: appBarTheme,
  inputDecorationTheme: otpInputDecorationTheme,
);

var appBarTheme = const AppBarTheme(
  surfaceTintColor: kWhiteColor,
);
var otpInputDecorationTheme = InputDecorationTheme(
  hintStyle: layer2,
  border: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
  errorBorder: errorInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: kTextColor1),
  );
}

OutlineInputBorder enabledInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: kDefaultColor1),
  );
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: kErrorColor1),
  );
}
