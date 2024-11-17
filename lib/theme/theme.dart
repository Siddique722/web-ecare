import 'package:ecare/constants/linker.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    //textTheme: GoogleFonts.gloryTextTheme(),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade200,
        primaryContainer: Colors.white,
        primary: AppColors.blackColor,
        secondary: AppColors.whiteColor,
        error: AppColors.whiteColor));

ThemeData darkMode = ThemeData(
    textTheme: TextTheme(),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: AppColors.blackColor,
        primaryContainer: Colors.grey.shade800,
        primary: AppColors.whiteColor,
        secondary: AppColors.whiteColor,
        error: AppColors.blackColor));
