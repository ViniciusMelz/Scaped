import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/config/themes/app_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _MainAppState();
}

class _MainAppState extends State<AppWidget> {
  late AppTheme appTheme;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      appTheme = Modular.get<AppTheme>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ApplicationTheme>(
      valueListenable: appTheme.themeNotifier,
      builder: (context, value, child) => MaterialApp.router(
        theme: appTheme.theme,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
      ),
    );
  }
}
