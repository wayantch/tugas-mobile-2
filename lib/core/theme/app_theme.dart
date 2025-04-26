import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final light = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(),
    // buttonColor: Colors.blue,
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.grey.shade900),
      titleTextStyle: TextStyle(
        color: Colors.grey.shade900,
        fontSize: 20,
        // fontWeight: FontWeight.w400,
      ),
      // elevation: 1,
      // centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(25),
      hintStyle: const TextStyle(
        color: Color(0xff383838),
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black, width: 0.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black, width: 0.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black, width: 0.8),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade800),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),


    textTheme: GoogleFonts.robotoTextTheme(Typography.blackCupertino),
    // textSelectionTheme: TextSelectionThemeData(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade100,
    ),
    scaffoldBackgroundColor: Colors.white,
    // primaryColor: Colors.blue.shade200,
    primaryColorLight: const Color.fromARGB(255, 235, 246, 254),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
  );
  static final dark = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(),
    // buttonColor: Colors.red,
    // scaffoldBackgroundColor: Colors.black,
    // primaryColor: Colors.black45,
    primaryColorLight: const Color.fromARGB(133, 25, 25, 25),
    appBarTheme: const AppBarTheme(
      // elevation: 1,
      // centerTitle: true,
      // color: Colors.white,
      // titleTextStyle: TextStyle(color: Colors.black),
      // iconTheme: IconThemeData(color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.robotoTextTheme(Typography.blackCupertino),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black),
    snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.black),
  );
}
