import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'constants/strings.dart';
import 'controllers/theme_provider.dart';
import 'views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: lightBackgroundColor,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: lightBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: darkColor,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: darkColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      builder: (ctx, _) {
        final _themeProvider = Provider.of<ThemeProvider>(ctx);
        return MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          themeMode: _themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: _analytics)
          ],
          home: SplashScreen(),
        );
      },
    );
  }
}
