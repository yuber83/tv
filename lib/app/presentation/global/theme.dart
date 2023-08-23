import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData getTheme(bool darkMode) {
  if (darkMode) {
    final darkTheme = ThemeData.dark();
    final darkTextTheme = darkTheme.textTheme;
    const boldStyle = TextStyle(fontWeight: FontWeight.bold);
    const whiteStyle = TextStyle(color: Colors.white);
    return darkTheme.copyWith(
      // scaffoldBackgroundColor: Color(0xff1c313a),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        elevation: 0,
      ),
      textTheme: GoogleFonts.nunitoSansTextTheme(
        darkTextTheme.copyWith(
          titleSmall: darkTextTheme.titleSmall?.merge(boldStyle),
          titleMedium: darkTextTheme.titleMedium?.merge(boldStyle),
          titleLarge: darkTextTheme.titleLarge?.merge(boldStyle),
          bodySmall: darkTextTheme.bodySmall?.merge(whiteStyle),
        ),
      ),
      scaffoldBackgroundColor: AppColors.darkLight,
      canvasColor: AppColors.dark,
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all(
          Colors.lightBlue.withOpacity(0.5),
        ),
        thumbColor: MaterialStateProperty.all(
          Colors.blue,
        ),
      ),
    );
  }
  final lightTheme = ThemeData.light();
  final lightTextTheme = lightTheme.textTheme;
  const boldStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );
  const darkStyle = TextStyle(color: Colors.black);
  return lightTheme.copyWith(
      textTheme: GoogleFonts.nunitoSansTextTheme(
        lightTextTheme.copyWith(
            titleSmall: lightTextTheme.titleSmall?.merge(boldStyle),
            titleMedium: lightTextTheme.titleMedium?.merge(boldStyle),
            titleLarge: lightTextTheme.titleLarge?.merge(boldStyle),
            bodySmall: lightTextTheme.bodySmall?.merge(darkStyle)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.dark,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.dark,
        ),
      ),
      tabBarTheme: const TabBarTheme(labelColor: AppColors.dark));
}
