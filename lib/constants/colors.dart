import 'package:flutter/material.dart';

const Color firstColor = Color.fromRGBO(60, 185, 145, 1);
const Color secondColor = Color(0xFF01BAEF);
const Color accentColor = Color(0xFF0D8E53);
const Color thirdColor = Color(0xFF6495ED);
const Color lightBackgroundColor = Color.fromRGBO(245, 245, 245, 1);
const Color darkBottomBarColor = Color(0xFF242424);
Color shadowColor = Color(0xFF000000).withOpacity(0.2);

const kTextColor = Color(0xFF1E2432);
const kTextMediumColor = Color(0xFF53627C);
const kTextLightColor = Color(0xFFACB1C0);
const kBackgroundColor = Color(0xFFFCFCFC);
const kInactiveChartColor = Color(0xFFEAECEF);
const Color infectedColor = Color(0xFFFF8C00);
const Color recoveredColor = Color(0xFF20BF55);
const Color deathColor = Color(0xFFFF2D55);

Map<int, Color> accColor = {
  50: Color.fromRGBO(13, 142, 83, .1),
  100: Color.fromRGBO(13, 142, 83, .2),
  200: Color.fromRGBO(13, 142, 83, .3),
  300: Color.fromRGBO(13, 142, 83, .4),
  400: Color.fromRGBO(13, 142, 83, .5),
  500: Color.fromRGBO(13, 142, 83, .6),
  600: Color.fromRGBO(13, 142, 83, .7),
  700: Color.fromRGBO(13, 142, 83, .8),
  800: Color.fromRGBO(13, 142, 83, .9),
  900: Color.fromRGBO(13, 142, 83, 1),
};

Map<int, Color> dark = {
  50: Color.fromRGBO(18, 18, 18, .1),
  100: Color.fromRGBO(18, 18, 18, .2),
  200: Color.fromRGBO(18, 18, 18, .3),
  300: Color.fromRGBO(18, 18, 18, .4),
  400: Color.fromRGBO(18, 18, 18, .5),
  500: Color.fromRGBO(18, 18, 18, .6),
  600: Color.fromRGBO(18, 18, 18, .7),
  700: Color.fromRGBO(18, 18, 18, .8),
  800: Color.fromRGBO(18, 18, 18, .9),
  900: Color.fromRGBO(18, 18, 18, 1),
};

MaterialColor materialAccentColor = MaterialColor(0xFF0D8E53, accColor);

MaterialColor materialDarkColor = MaterialColor(0xFF121212, dark);
