// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String appName = "Note";
const String appVersion = "v 0.0.0.1";

const kPrimaryColor1 = Color(0xFF3EB489);
const kSecondaryColor = Color(0xFFFF715B);
const kAccentColor = Color(0xFF3F4042);
const kWhiteColor = Color(0xFFFFFFFF);
const kTransparentColor = Colors.transparent;
const kGreyColor = Color(0xFFC5C5C5);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    kPrimaryColor1,
    kPrimaryColor1,
  ],
);

const kTextColor1 = Color(0xFF000000);
const kTextColor2 = Color(0xFF1A1A1A);
const kTextColor3 = Color(0xFF333333);
const kTextColor4 = Color(0xFF4D4D4D);
const kTextColor5 = Color(0xFF095296);
const kErrorColor1 = Color(0xFFFF0000);
const kErrorColor2 = Color(0xFFFF0000);
const kDefaultColor1 = Color(0xFF4D4D4D);
const kDefaultColor2 = Color(0xFF808080);
const kDefaultColor3 = Color(0xFFB3B3B3);
const kDefaultColor4 = Color(0xFFCCCCCC);

const kAnimationDuration = Duration(milliseconds: 650);

final EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 24.h);
final heading = TextStyle(
  fontSize: 48.sp,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
final heading1 = TextStyle(
  fontSize: 32.sp,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
final heading2 = TextStyle(
  fontSize: 24.sp,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
final heading3 = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);
final heading3White = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.normal,
  color: kWhiteColor,
);
final heading3Default = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.normal,
  color: kPrimaryColor1,
);

final subTitle = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

final layer1 = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

final layer2 = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);
const buttonWhite = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: kWhiteColor,
  height: 1.5,
);
const buttonPrimary = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: kPrimaryColor1,
  height: 1.5,
);
const body1 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: kDefaultColor2,
  height: 1.5,
);
const body2 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
  height: 1.5,
);
const bodyForPq = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.black,
  height: 1.5,
);
const subLayer = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: Colors.black,
  height: 1.5,
);
const subHeading2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String FIELD_REQUIRED_MSG = "This field is required";
const String loremSentence = '''
Pariatur officia laborum incididunt duis elit id mollit mollit magna esse nulla cupidatat minim. Aute nisi aliquip fugiat deserunt ullamco. Excepteur id ullamco anim nisi magna esse esse mollit eu aliqua fugiat. Minim qui laborum proident mollit ex laborum incididunt et eu exercitation deserunt. Officia nulla aliqua cupidatat et anim reprehenderit laborum veniam. Consectetur cillum anim commodo ad do et magna Lorem aliquip laborum ut eu deserunt.Ea minim cupidatat consectetur ad amet deserunt minim velit officia qui ex et fugiat occaecat. Nisi incididunt aute ex amet minim ad ea sit officia qui aute. Eiusmod ut consectetur consectetur ad. Ad mollit nulla veniam reprehenderit occaecat reprehenderit reprehenderit veniam ad.Culpa laboris deserunt commodo reprehenderit aliqua aliquip commodo. Reprehenderit commodo amet do voluptate minim duis adipisicing ut exercitation nostrud sit. Commodo elit nulla reprehenderit consequat esse duis pariatur ullamco reprehenderit ea. Exercitation minim laborum ipsum duis ut magna qui aliquip tempor ipsum reprehenderit tempor tempor.Excepteur aliqua velit eiusmod amet proident est irure eiusmod minim. Magna ullamco aliqua sit fugiat enim fugiat labore ad est aliquip nisi irure officia quis. Fugiat enim fugiat proident veniam laborum amet id do labore incididunt.Sunt eiusmod commodo sint voluptate in non. Esse cupidatat esse anim esse reprehenderit irure veniam. Commodo cupidatat officia amet non. Labore quis amet esse id magna ad adipisicing sunt culpa cupidatat deserunt. Commodo labore dolore commodo id velit. Magna nostrud voluptate elit do esse non velit aute ea. Ex sunt ex officia officia veniam deserunt nulla ad ipsum est minim tempor veniam.Incididunt incididunt mollit labore sint exercitation id Lorem cillum ex ex. Tempor velit non enim non amet non fugiat eiusmod consectetur excepteur est minim proident cupidatat. Et ut enim dolore irure. Mollit consequat anim non nulla aliqua ea ea esse in laboris occaecat esse do consectetur.Magna voluptate elit cillum aliqua id cillum labore qui excepteur et nulla cupidatat. Adipisicing velit qui culpa consectetur. Voluptate in proident et reprehenderit labore tempor laborum ad est labore ad sit. Aliquip Lorem occaecat ex anim veniam non sunt officia ipsum qui et dolor commodo dolore. Lorem in amet sit elit pariatur.Fugiat voluptate enim nostrud irure sit commodo nisi sint mollit incididunt. Non fugiat veniam labore dolore enim ullamco qui veniam id exercitation proident irure dolore in. Id voluptate veniam aliqua sit ullamco anim consequat officia. Laborum Lorem incididunt Lorem voluptate sit. Lorem irure dolore tempor nisi anim qui nostrud officia tempor commodo. Exercitation voluptate reprehenderit ex proident minim eiusmod tempor dolore occaecat sunt nulla pariatur nostrud irure.''';
