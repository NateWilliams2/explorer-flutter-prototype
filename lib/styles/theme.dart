import 'package:flutter/material.dart';
import 'colors.dart';

final mainTheme = ThemeData(
    primarySwatch: primarySwatch,
    fontFamily: "Open Sans",
    textTheme: TextTheme(
      button: TextStyle(color: backgroundTextColor),
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    accentIconTheme: IconThemeData(color: backgroundTextColor),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(backgroundTextColor))));
