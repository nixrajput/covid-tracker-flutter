import 'package:covid_tracker/constants/colors.dart';
import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/screens/about_page.dart';
import 'package:covid_tracker/screens/guidelines_screen.dart';
import 'package:covid_tracker/screens/home_screen.dart';
import 'package:covid_tracker/screens/splash_screen.dart';
import 'package:covid_tracker/utils/custom_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: lightBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: darkBottomBarColor,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: materialDarkColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        scaffoldBackgroundColor: lightBackgroundColor,
        primarySwatch: materialAccentColor,
        accentColor: materialAccentColor,
        bottomAppBarColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          TargetPlatform.iOS: CustomPageTransitionBuilder(),
        }),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: materialDarkColor,
        bottomAppBarColor: darkBottomBarColor,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: darkBottomBarColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          TargetPlatform.iOS: CustomPageTransitionBuilder(),
        }),
      ),
      home: SplashScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        GuidelinesScreen.routeName: (ctx) => GuidelinesScreen(),
        AboutPage.routeName: (ctx) => AboutPage(),
      },
    );
  }
}
