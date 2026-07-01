import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elaveoironing_vendor/res/color_pallete.dart';

class FontPalette {
  static const themeFont = "Poppins";

  //Light => w300
  //Regular => w400
  //Medium => w500
  //Semi Bold => w600
  //Bold => w700
  //Extra Bold => w800

  //8
  static TextStyle f888888_8Medium = GoogleFonts.inter(
      fontSize: 8.sp, color: HexColor("#888888"), fontWeight: FontWeight.w500);

  //9
  static TextStyle f00C159_9Medium = GoogleFonts.inter(
      fontSize: 12.sp, color: HexColor("#2CC171"), fontWeight: FontWeight.w500);
  static TextStyle forgotpass9Medium = GoogleFonts.inter(
      fontSize: 9.sp, color: HexColor("#757171"), fontWeight: FontWeight.w500);

  //black
  static TextStyle black29600 = GoogleFonts.inter(
      fontSize: 29.sp, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle black28500 = GoogleFonts.inter(
      fontSize: 28.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle black23600 = GoogleFonts.inter(
      fontSize: 23.sp, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle black23500 = GoogleFonts.inter(
      fontSize: 23.sp, color: Colors.black, fontWeight: FontWeight.w500);

  static TextStyle black21500 = GoogleFonts.inter(
      fontSize: 21.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle black21700 = GoogleFonts.inter(
      fontSize: 21.sp, color: Colors.black, fontWeight: FontWeight.w700);
  static TextStyle black21400 = GoogleFonts.inter(
      fontSize: 21.sp, color: Colors.black, fontWeight: FontWeight.w400);
  static TextStyle black16500 = GoogleFonts.inter(
      fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle white21400 = GoogleFonts.inter(
      fontSize: 21.sp, color: Colors.white, fontWeight: FontWeight.w400);
  static TextStyle black17500 = GoogleFonts.inter(
      fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle black13400 = GoogleFonts.inter(
      fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w400);
  static TextStyle black13500 = GoogleFonts.inter(
      fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle black9500 = GoogleFonts.inter(
      fontSize: 9.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle black11600 = GoogleFonts.inter(
      fontSize: 11.sp, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle black12400 = GoogleFonts.inter(
      fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w400);
  static TextStyle blue11700 = GoogleFonts.inter(
      fontSize: 11.sp,
      color: Color.fromRGBO(84, 151, 230, 1),
      fontWeight: FontWeight.w700);

  static TextStyle black12600 = GoogleFonts.inter(
      fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle black10500 = GoogleFonts.inter(
      fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle black11500 = GoogleFonts.inter(
      fontSize: 11.sp, color: Colors.black, fontWeight: FontWeight.w500);

  static TextStyle black10600 = GoogleFonts.inter(
      fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle black13600 = GoogleFonts.inter(
      fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w600);
  static TextStyle black15600 = GoogleFonts.inter(
      fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle black15500 = GoogleFonts.inter(
      fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle black15700 = GoogleFonts.inter(
      fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.w700);
//lightblack
  static TextStyle lightblack14500 = GoogleFonts.inter(
      fontSize: 14.sp, color: HexColor("#595959"), fontWeight: FontWeight.w500);
  static TextStyle lightblack12500 = GoogleFonts.inter(
      fontSize: 12.sp, color: HexColor("#595959"), fontWeight: FontWeight.w500);
  static TextStyle lightblack11500 = GoogleFonts.inter(
      fontSize: 11.sp, color: HexColor("#595959"), fontWeight: FontWeight.w500);

  static TextStyle lightblack13600 = GoogleFonts.inter(
      fontSize: 13.sp, color: HexColor("#595959"), fontWeight: FontWeight.w600);
//  static TextStyle lightblack1300 = GoogleFonts.inter(
//       fontSize: 13.sp, color: HexColor("#565656"), fontWeight: FontWeight.w600);

  //white
  static TextStyle darkteal15500 = GoogleFonts.inter(
      fontSize: 15.sp, color: HexColor("#00796B"), fontWeight: FontWeight.w500);
  static TextStyle anodarkteal15500 = GoogleFonts.inter(
      fontSize: 15.sp, color: HexColor("#004D40"), fontWeight: FontWeight.w500);
  static TextStyle anodark15500 = GoogleFonts.inter(
      fontSize: 15.sp, color: HexColor("#333333"), fontWeight: FontWeight.w500);

  static TextStyle white15500 = GoogleFonts.inter(
      fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.w500);
  static TextStyle white14400 = GoogleFonts.inter(
      fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w400);
  static TextStyle white14500 = GoogleFonts.inter(
      fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w500);

  static TextStyle white12500 = GoogleFonts.inter(
      fontSize: 11.sp, color: Colors.white, fontWeight: FontWeight.w500);
  static TextStyle white9500 = GoogleFonts.inter(
      fontSize: 9.sp, color: Colors.white, fontWeight: FontWeight.w500);

  //blue
  static TextStyle blue13500 = GoogleFonts.inter(
      fontSize: 13.sp, color: HexColor("#2794D1"), fontWeight: FontWeight.w500);
  static TextStyle blue17700 = GoogleFonts.inter(
      fontSize: 16.sp, color: HexColor("#075789"), fontWeight: FontWeight.w700);
  static TextStyle blue21700 = GoogleFonts.inter(
      fontSize: 21.sp,
      color: Color.fromRGBO(21, 137, 110, 1),
      fontWeight: FontWeight.w700);
  //grey

  static TextStyle grey11400 = GoogleFonts.inter(
      fontSize: 11.sp, color: HexColor("#716A6A"), fontWeight: FontWeight.w400);
  static TextStyle grey15500 = GoogleFonts.inter(
      fontSize: 13.sp,
      color: const Color.fromARGB(255, 124, 124, 124),
      fontWeight: FontWeight.w500);
  static TextStyle grey12400 = GoogleFonts.inter(
      fontSize: 12.sp, color: HexColor("#716A6A"), fontWeight: FontWeight.w400);
  static TextStyle viewcloths12400 = GoogleFonts.inter(
      fontSize: 12.sp,
      color: Color.fromARGB(255, 13, 117, 169),
      fontWeight: FontWeight.w400);

  //green
  static TextStyle green18700 = GoogleFonts.inter(
      fontSize: 16.sp, color: HexColor("#807D3A"), fontWeight: FontWeight.w700);
  static TextStyle green17500 = GoogleFonts.inter(
      fontSize: 17.sp, color: HexColor("#577D86"), fontWeight: FontWeight.w500);
  static TextStyle green11500 = GoogleFonts.inter(
      fontSize: 11.sp, color: HexColor("#008D6C"), fontWeight: FontWeight.w500);

  static TextStyle green30700 = GoogleFonts.inter(
      fontSize: 28.sp, color: HexColor("#2E896D"), fontWeight: FontWeight.w700);

  //brown
  static TextStyle brown11500 = GoogleFonts.inter(
      fontSize: 11.sp, color: HexColor("#875C45"), fontWeight: FontWeight.w500);
  static TextStyle brown17700 = GoogleFonts.inter(
      fontSize: 16.sp, color: HexColor("#A55922"), fontWeight: FontWeight.w700);
  static TextStyle brown10400 = GoogleFonts.inter(
      fontSize: 10.sp, color: HexColor("#704242"), fontWeight: FontWeight.w400);

  //lightgrey
  static TextStyle lightGrey12Regular = GoogleFonts.poppins(
      fontSize: 12.sp, color: HexColor("#A6A9A7"), fontWeight: FontWeight.w400);
}
