// Width
import 'package:flutter/material.dart';

double valueVerySmall = 5;
double valueSmall = 10;
double valueMedium = 13;
double valueSecondMedium = 15;
double valueLarge = 20;
double valueSecondLarge = 25;
double valueVeryLarge = 55;

// Space (Sizedbox)
// Width
Widget spaceWidthSmall = SizedBox(width: valueSmall);
Widget spaceWidthVerySmall = SizedBox(width: valueVerySmall);
Widget spaceWidthMedium = SizedBox(width: valueMedium);
Widget spaceWidthLarge = SizedBox(width: valueLarge);
// Height
Widget spaceHeightSmall = SizedBox(height: valueSmall);
Widget spaceHeightMedium = SizedBox(height: valueMedium);
Widget spaceHeightSecondMedium = SizedBox(height: valueSecondMedium);
Widget spaceHeightLarge = SizedBox(height: valueLarge);
Widget spaceHeightSecondLarge = SizedBox(height: valueSecondLarge);
Widget spaceHeightVeryLarge = SizedBox(height: valueVeryLarge);

// Type Text
// bold light
const textBoldLightSmall = TextStyle(
  fontSize: 8,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
const textBoldLightMedium = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
const textBoldLightLarge = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
const textBoldLightSecondLarge = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

// Bold Dark
const textBoldDarkSmall = TextStyle(
  fontSize: 9,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
const textBoldDarkMedium = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
const textBoldDarkLarge = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
const textBoldDarkVeryLarge = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);
