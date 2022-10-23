import 'package:dashboard/core/core.dart';
import 'package:dashboard/generated/l10n.dart';
import 'package:dashboard/views/pages/categories/create.dart';
import 'package:dashboard/views/pages/categories/detail.dart';
import 'package:dashboard/views/pages/main/main_page.dart';
import 'package:dashboard/views/pages/products/create.dart';
import 'package:dashboard/views/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:utilities/utilities.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.blue
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.transparent
    ..maskColor = Colors.blue
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(const App());
}

class App extends StatefulWidget {
  const App({final Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(final BuildContext context) => GetMaterialApp(
        enableLog: false,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: const <Locale>[Locale("en"), Locale("fa")],
        locale: const Locale("en"),
        theme: AppThemes.lightTheme,
        home: const SplashPage(),
        builder: EasyLoading.init(),
      );
}
