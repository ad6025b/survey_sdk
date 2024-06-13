import 'package:flutter/material.dart';
import 'package:survey_sdk/activity_sdk.dart';

abstract class AppTheme {
  static final theme = ThemeData(
    appBarTheme: const AppBarTheme(
      toolbarHeight: ActivityDimensions.appbarHeight,
      shadowColor: ActivityColors.transparentW,
      backgroundColor: ActivityColors.white,
    ),
    listTileTheme: const ListTileThemeData(
      selectedColor: ActivityColors.black,
      selectedTileColor: ActivityColors.greyBackground,
    ),
    dividerTheme: const DividerThemeData(
      space: ActivityDimensions.thinBorderWidth,
      color: ActivityColors.greyBackground,
      thickness: ActivityDimensions.thinBorderWidth,
    ),
    iconTheme: const IconThemeData(
      color: ActivityColors.black,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ActivityColors.black,
      unselectedLabelColor: ActivityColors.tabBarInactiveText,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ActivityColors.black),
      ),
    ),
    fontFamily: ActivityFonts.inter,
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: ActivityColors.black),
      titleSmall: TextStyle(
        color: ActivityColors.black,
        fontWeight: ActivityFonts.weightSemiBold,
      ),
      bodyLarge: TextStyle(color: ActivityColors.black),
      bodyMedium: TextStyle(color: ActivityColors.black),
      bodySmall: TextStyle(color: ActivityColors.black),
      labelLarge: TextStyle(
        color: ActivityColors.black,
        fontWeight: ActivityFonts.weightBold,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(foregroundColor: ActivityColors.black),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ActivityColors.black,
    ),
  );
}
