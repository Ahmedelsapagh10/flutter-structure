import 'package:flutter/material.dart';

import 'package:new_strucuture/core/utils/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme({required BuildContext context}) {
    return ThemeData(
      fontFamily: 'Cairo',
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bgLigth,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: AppColors.textLight, fontSize: 14),
        bodyMedium: TextStyle(color: AppColors.textLight, fontSize: 16),
        bodyLarge: TextStyle(color: AppColors.textLight, fontSize: 18),
        titleLarge: TextStyle(
            color: AppColors.textLight,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: AppColors.textLight,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        checkColor: WidgetStatePropertyAll<Color>(AppColors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.grey2Light,
        filled: true,
      ),
      tabBarTheme: TabBarThemeData(
        overlayColor: WidgetStatePropertyAll(AppColors.primary),
        labelStyle: TextStyle(
            fontSize: 14, fontFamily: 'Tajawal', fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
            fontSize: 14, fontFamily: 'Tajawal', fontWeight: FontWeight.bold),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.greyfa,
        indicatorColor: AppColors.primary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppColors.text2Light),
          backgroundColor: WidgetStatePropertyAll(AppColors.bgLigth),
          overlayColor: WidgetStatePropertyAll(AppColors.greyfa),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(backgroundColor: AppColors.white),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        shadowColor: AppColors.greyfa,
        color: AppColors.white,
        toolbarHeight: 60,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  static ThemeData darkTheme({required BuildContext context}) {
    return ThemeData(
      fontFamily: 'Cairo',
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bgDark,
      textTheme: TextTheme(
        bodySmall: TextStyle(color: AppColors.textDark, fontSize: 14),
        bodyMedium: TextStyle(color: AppColors.textDark, fontSize: 16),
        bodyLarge: TextStyle(color: AppColors.textDark, fontSize: 18),
        titleLarge: TextStyle(
            color: const Color.fromARGB(255, 255, 23, 23),
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: AppColors.textDark,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        checkColor: WidgetStatePropertyAll<Color>(AppColors.bgDark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFF2b3444),
        filled: true,
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppColors.textDark),
        labelStyle: TextStyle(color: AppColors.textDark),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(AppColors.text2Dark),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        overlayColor: WidgetStatePropertyAll(AppColors.primary),
        labelStyle: TextStyle(
            fontSize: 14, fontFamily: 'Tajawal', fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
            fontSize: 14, fontFamily: 'Tajawal', fontWeight: FontWeight.bold),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.greyfa,
        indicatorColor: AppColors.primary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(AppColors.text2Dark),
          backgroundColor: WidgetStatePropertyAll(AppColors.bgDark),
          overlayColor: WidgetStatePropertyAll(AppColors.grey2Dark),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(backgroundColor: AppColors.black),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
        shadowColor: AppColors.greyfa,
        color: AppColors.bgDark,
        toolbarHeight: 60,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
