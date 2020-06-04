import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

final Color colorWhite=Color(0xffECF0BC);
final Color colorBlue=Color(0xffECF0BC);
final Color colorRed=Color(0xff863542);
final Color colorDark=Color(0xff232830);
final Color colorYellow=Color(0xffF0B88C);
final Color colorYellowDark=Color(0xffDAABA0);
ThemeData darkTheme = ThemeData(
  accentColor: colorBlue,
  accentColorBrightness: Brightness.light ,
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: colorWhite),
    textTheme: TextTheme(
      headline6: GoogleFonts.lekton(color: colorWhite,fontWeight: FontWeight.w500,fontSize: 18 ),
    )
  ),
  backgroundColor:  colorDark,
  primaryColor:colorBlue,
  scaffoldBackgroundColor: colorDark,
  buttonTheme: ButtonThemeData(

  ),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.lekton(color: colorWhite,fontWeight: FontWeight.w400,fontSize: 16 ),
    bodyText2: GoogleFonts.lekton(color: colorWhite,fontWeight: FontWeight.w400 ,fontSize: 14),
    button: GoogleFonts.lekton(color: colorWhite,fontWeight: FontWeight.w500 ,fontSize: 14),
   subtitle1:  GoogleFonts.lekton(color: colorWhite,fontWeight: FontWeight.w400 ,fontSize: 16),
    subtitle2: GoogleFonts.lekton(color: colorWhite,fontWeight: FontWeight.w400,fontSize: 14 ),
  ),
  iconTheme: IconThemeData(
    color: colorWhite
  )

);

final Color colorFullWhite=Color(0xffffffff);
ThemeData lightTheme = ThemeData(
    accentColor: colorBlue,
    accentColorBrightness: Brightness.dark ,
    appBarTheme: AppBarTheme(
        textTheme: TextTheme(
            headline6: GoogleFonts.lekton(color: colorDark,fontWeight: FontWeight.w500,fontSize: 16 )
        ),
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorDark)
    ),

    backgroundColor:  colorFullWhite,
    primaryColor:colorBlue,
    scaffoldBackgroundColor: colorFullWhite,
    buttonTheme: ButtonThemeData(

    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.lekton(color: colorDark,fontWeight: FontWeight.w400,fontSize: 16 ),
      bodyText2: GoogleFonts.lekton(color: colorDark,fontWeight: FontWeight.w400 ,fontSize: 14),
      button: GoogleFonts.lekton(color: colorDark,fontWeight: FontWeight.w500 ,fontSize: 14),
      subtitle1:  GoogleFonts.lekton(color: colorDark,fontWeight: FontWeight.w400 ,fontSize: 16),
      subtitle2: GoogleFonts.lekton(color: colorDark,fontWeight: FontWeight.w400,fontSize: 14 ),
    ),
    iconTheme: IconThemeData(
        color: colorDark
    )

);