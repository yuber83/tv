import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'generated/assets.gen.dart';
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
        theme: getTheme(themeController.darkMode),
        initialRoute: Routes.spash,
        routes: appRoutes,
        onUnknownRoute: (_) => MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Assets.svgs.error404.svg(),
                  ),
                )),
      ),
    );
  }
}
