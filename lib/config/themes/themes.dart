import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      // textTheme: GoogleFonts.poppinsTextTheme(),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      brightness: Brightness.light,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      // textTheme: GoogleFonts.poppinsTextTheme().apply(
      //   bodyColor: Colors.white,
      // ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      brightness: Brightness.dark,
    );
  }
}
