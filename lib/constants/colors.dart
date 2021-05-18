import 'package:flutter/material.dart';

const Color firstColor = Color(0xFF8A1342);
const Color secondColor = Color(0xFF1c93ee);
const Color lightBackgroundColor = Color.fromRGBO(242, 242, 242, 1);
const Color darkBottomBarColor = Color(0xFF012545);
Color shadowColor = Color(0xFF000000).withOpacity(0.2);

Map<int, Color> swatch = {
  50: Color.fromRGBO(138, 19, 66, .1),
  100: Color.fromRGBO(138, 19, 66, .2),
  200: Color.fromRGBO(138, 19, 66, .3),
  300: Color.fromRGBO(138, 19, 66, .4),
  400: Color.fromRGBO(138, 19, 66, .5),
  500: Color.fromRGBO(138, 19, 66, .6),
  600: Color.fromRGBO(138, 19, 66, .7),
  700: Color.fromRGBO(138, 19, 66, .8),
  800: Color.fromRGBO(138, 19, 66, .9),
  900: Color.fromRGBO(138, 19, 66, 1),
};

Map<int, Color> dark = {
  50: Color.fromRGBO(1, 26, 48, .1),
  100: Color.fromRGBO(1, 26, 48, .2),
  200: Color.fromRGBO(1, 26, 48, .3),
  300: Color.fromRGBO(1, 26, 48, .4),
  400: Color.fromRGBO(1, 26, 48, .5),
  500: Color.fromRGBO(1, 26, 48, .6),
  600: Color.fromRGBO(1, 26, 48, .7),
  700: Color.fromRGBO(1, 26, 48, .8),
  800: Color.fromRGBO(1, 26, 48, .9),
  900: Color.fromRGBO(1, 26, 48, 1),
};

MaterialColor swatchColor = MaterialColor(0xFF8A1342, swatch);
MaterialColor darkColor = MaterialColor(0xFF011a30, dark);
