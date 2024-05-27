import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'shared.dart';
part 'color_palette.dart';

double defaultMargin = 24;

Color primaryColor = Color(0xFFFFFFFF);
Color secondaryColor = Color(0xFF0275CD);
Color dangerColor = Color(0xFFFF0000);
Color blackColor = Color(0xFF050522);
Color blueColor = Color(0xFF0275CD);

TextStyle blackTextStyle = GoogleFonts.roboto(
  fontSize: 36, color: blackColor, fontWeight: FontWeight.w500);
TextStyle primaryTextStyle = GoogleFonts.poppins(
  fontSize: 14, color: primaryColor, fontWeight: FontWeight.w500);
TextStyle secondaryTextStyle = GoogleFonts.poppins(
  fontSize: 14, color: secondaryColor, fontWeight: FontWeight.w500);
TextStyle blueTextStyle = GoogleFonts.cormorantGaramond(
  fontSize: 20, color: blueColor, fontWeight: FontWeight.w500); 
