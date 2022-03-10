import 'package:flutter/material.dart';
import 'package:task/core/themes/screen_utility.dart';

class MainTheme {
  static TextStyle buttonTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Tajawal');
  static TextStyle hintTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: MainStyle.primaryColor,
      fontFamily: 'Tajawal');

  static TextStyle headingTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTextStyle =
      TextStyle(fontSize: 15, color: Colors.grey[200], fontFamily: 'Tajawal');
  static TextStyle subTextStyle2 = const TextStyle(
      fontSize: 10, color: MainStyle.primaryColor, fontFamily: 'Tajawal');

  static TextStyle errorTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.red,
      fontFamily: 'Tajawal');
  static String productTextFont =
      'ExpoArabic';
}
