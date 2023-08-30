import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/assets.gen.dart';
import 'generated/translations.g.dart';
import 'presentation/global/controllers/theme_controlloer.dart';
import 'presentation/global/theme.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        initialRoute: Routes.spash,
        routes: appRoutes,
        theme: getTheme(themeController.darkMode),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocaleUtils.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
        onUnknownRoute: (_) => MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Assets.svgs.error404.svg(),
            ),
          ),
        ),
      ),
    );
  }
}
