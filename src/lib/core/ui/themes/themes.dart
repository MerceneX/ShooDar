import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  const primaryColor = Color.fromRGBO(50, 139, 255, 1.0);
  const secColor = Color.fromRGBO(230, 120, 0, 1.0);
  const bckgColor = Color.fromRGBO(142, 180, 229, 1.0);
  const primaryText = Color.fromRGBO(244, 244, 255, 1.0);
  const secText = Color.fromRGBO(10, 10, 10, 1.0);
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: primaryColor,
    backgroundColor: bckgColor,
    accentColor: secColor,

    inputDecorationTheme: InputDecorationTheme(
      fillColor: primaryText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      hintStyle: TextStyle(color: primaryText),
    ),
    // Define the default font family.
      fontFamily: 'Roboto',

    buttonTheme: ButtonThemeData(
      splashColor: primaryColor,
      highlightColor: secColor.withOpacity(0.75),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      textTheme: ButtonTextTheme.primary,
    ),

    buttonColor: primaryColor,

    primaryIconTheme: IconThemeData(
      color: primaryText,
    ),

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline2: TextStyle(
          fontSize: 35, fontWeight: FontWeight.bold, color: primaryText),
      headline1: GoogleFonts.sriracha(fontSize: 50, color: primaryText),
      bodyText1:
          TextStyle(fontSize: 22.0, fontFamily: 'Hind', color: primaryText),
    ),
  );
}
