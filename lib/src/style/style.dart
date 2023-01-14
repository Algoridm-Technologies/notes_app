import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/src/utils/constants.dart';

var appTheme = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  useMaterial3: true,
  splashColor: kPrimaryColor1,
  hoverColor: kPrimaryColor1,
  backgroundColor: kWhiteColor,
  scaffoldBackgroundColor: kWhiteColor,
  primaryColor: kPrimaryColor1,
  primaryColorDark: kPrimaryColor1,
  primaryColorLight: kPrimaryColor1,
  appBarTheme: appBarTheme,
);

var appBarTheme = const AppBarTheme(
  surfaceTintColor: kWhiteColor,
);
