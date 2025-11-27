import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTheme {
  static Color isDoneColor = const Color(0xff61E757);

  static ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xFF5D9CEC),
    scaffoldBackgroundColor: const Color(0xFFDFECDB),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF5D9CEC),
        primary: const Color(0xFF5D9CEC),
        onSecondary: const Color(0xFF000000),
        onSurface: const Color(0xff000000),
        onBackground: const Color(0xFFFFFFFF)),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Color(0xFF5D9CEC),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: Color(0xFF5D9CEC),
      ),
      selectedItemColor: Color(0xFF5D9CEC),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.shade500,
      ),
      unselectedItemColor: Colors.grey.shade500,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 20,
        color: Color(0xFF5D9CEC),
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF5D9CEC),
        // StadiumBorder make to circular by default
        shape: StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 4,
        ))),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xFF5D9CEC),
    scaffoldBackgroundColor: const Color(0xFF141A2E),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF141A2E),
        onSecondary: Color(0xffffffff),
        primary: const Color(0xFF141A2E),
        onSurface: const Color(0xff141922),
        onBackground: const Color(0xff141922)),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xff141922)),
      backgroundColor: Color(0xFF5D9CEC),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: Color(0xFF5D9CEC),
      ),
      selectedItemColor: Color(0xFF5D9CEC),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.shade500,
      ),
      unselectedItemColor: Colors.grey.shade500,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 20,
        color: Color(0xFF141922),
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF5D9CEC),
        // StadiumBorder make to circular by default
        shape: const StadiumBorder(
            side: BorderSide(
          color: Color(0xFF141922),
          width: 4,
        ))),
  );
}
