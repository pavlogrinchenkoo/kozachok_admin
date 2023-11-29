import 'package:flutter/material.dart';

class ThemeColors {
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff161621);
  static const Color primary = Color(0xff54537d);
  static const Color silver = Color(0xffF2F4F4);
  static const Color gray = Color(0xff94979A);
  static const Color boxShadow = Color(0x40000000);
  static const Color red = Color(0xFFFF0000);
  static const Color s100 = Color(0xffC9FFB0);
  static const Color s90 = Color(0xffD1F0AC);
  static const Color s80 = Color(0xffD7E6AA);
  static const Color s70 = Color(0xffDCDCA8);
  static const Color s60 = Color(0xffE2D2A6);
  static const Color s50 = Color(0xffE7C7A4);
  static const Color s40 = Color(0xffECBEA2);
  static const Color s30 = Color(0xffF2B3A0);
  static const Color s20 = Color(0xffF7A99D);
  static const Color s10 = Color(0xffFF9B9B);
}

abstract class BC {
  static Color get white => ThemeColors.white;

  static Color get black => ThemeColors.black;

  static Color get primary => ThemeColors.primary;

  static Color get silver => ThemeColors.silver;

  static Color get gray => ThemeColors.gray;

  static Color get boxShadow => ThemeColors.boxShadow;

  static Color get red => ThemeColors.red;
}

abstract class SC {
  static Color get s100 => ThemeColors.s100;

  static Color get s90 => ThemeColors.s90;

  static Color get s80 => ThemeColors.s80;

  static Color get s70 => ThemeColors.s70;

  static Color get s60 => ThemeColors.s60;

  static Color get s50 => ThemeColors.s50;

  static Color get s40 => ThemeColors.s40;

  static Color get s30 => ThemeColors.s30;

  static Color get s20 => ThemeColors.s20;

  static Color get s10 => ThemeColors.s10;
}

abstract class BS {
  static TextStyle get bold36 => TextStyle(
      color: BC.black,
      fontFamily: 'Gotham',
      fontSize: 36,
      fontWeight: FontWeight.w700);

  static TextStyle get med20 => TextStyle(
      color: BC.black,
      fontFamily: 'Gotham',
      fontSize: 20,
      fontWeight: FontWeight.w500);

  static TextStyle get med16 => TextStyle(
      color: BC.black,
      fontFamily: 'Gotham',
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static TextStyle get reg16 => TextStyle(
      color: BC.black,
      fontFamily: 'Gotham',
      fontSize: 16,
      fontWeight: FontWeight.w400);

  static TextStyle get reg12 => TextStyle(
      color: BC.black,
      fontFamily: 'Gotham',
      fontSize: 12,
      fontWeight: FontWeight.w400);

  static TextStyle get reg8 => TextStyle(
      color: BC.black,
      fontFamily: 'Gotham',
      fontSize: 8,
      fontWeight: FontWeight.w400);
}

abstract class BDuration {
  static Duration get d200 => const Duration(milliseconds: 200);

  static Duration get d100 => const Duration(milliseconds: 100);
}

abstract class BRadius {
  static BorderRadius get r2 => const BorderRadius.all(Radius.circular(2));

  static BorderRadius get r6 => const BorderRadius.all(Radius.circular(6));

  static BorderRadius get r16 => const BorderRadius.all(Radius.circular(16));

  static BorderRadius get r64 => const BorderRadius.all(Radius.circular(64));
}

abstract class BShadow {
  static List<BoxShadow> get def => [
        BoxShadow(
            color: BC.boxShadow, blurRadius: 4, offset: const Offset(0, 4))
      ];
}
