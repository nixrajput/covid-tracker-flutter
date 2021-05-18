import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../constants/colors.dart';
import 'custom_route.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: darkColor,
    accentColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: darkBottomBarColor),
    bottomAppBarColor: darkBottomBarColor,
    cardTheme: CardTheme(color: darkBottomBarColor),
    dialogTheme: DialogTheme(backgroundColor: darkBottomBarColor),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: darkBottomBarColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    }),
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: swatchColor),
    scaffoldBackgroundColor: lightBackgroundColor,
    primarySwatch: swatchColor,
    accentColor: swatchColor,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    bottomAppBarColor: Colors.white,
    cardTheme: CardTheme(color: Colors.white),
    dialogTheme: DialogTheme(backgroundColor: Colors.white),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    }),
  );
}
