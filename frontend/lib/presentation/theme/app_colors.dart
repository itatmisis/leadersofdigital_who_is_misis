import 'package:flutter/material.dart';

extension ColorX on Color {
  String toHexTriplet() => '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

class AppColors {
  static const Color neutral900 = Color(0xFF252525);
  static const Color neutral800 = Color(0xFF3A3A3A);
  static const Color neutral700 = Color(0xFF505050);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral500 = Color(0xFFB5B5B5);
  static const Color neutral400 = Color(0xFFD4D4D4);
  static const Color neutral300 = Color(0xFFE2E2E2);
  static const Color neutral200 = Color(0xFFECECEC);
  static const Color neutral100 = Color(0xFFF9F9F9);

  static const Color ultraBlack = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF242729);
  static const Color gray = Color(0xFF6D6D73);
  static const Color lightGray = Color(0xFF919399);

  static const Color veryPeri900 = Color(0xFF2B2C4F);
  static const Color veryPeri800 = Color(0xFF414276);
  static const Color veryPeri700 = Color(0xFF505191);
  static const Color veryPeri600 = Color(0xFF6162A8);
  static const Color veryPeri500 = Color(0xFF6667AB);
  static const Color veryPeri400 = Color(0xFF7B7CB7);
  static const Color veryPeri300 = Color(0xFFBDBEDB);
  static const Color veryPeri200 = Color(0xFFE4E4F0);
  static const Color veryPeri100 = Color(0xFFA3A4CC);

  static const Color eggshellBlue900 = Color(0xFF478581);
  static const Color eggshellBlue800 = Color(0xFF60A9A4);
  static const Color eggshellBlue700 = Color(0xFF7AB8B4);
  static const Color eggshellBlue600 = Color(0xFF95C6C3);
  static const Color eggshellBlue500 = Color(0xFF9ECBC8);
  static const Color eggshellBlue400 = Color(0xFFAFD4D2);
  static const Color eggshellBlue300 = Color(0xFFAFD4D2);
  static const Color eggshellBlue200 = Color(0xFFBDDBD9);
  static const Color eggshellBlue100 = Color(0xFFCAE2E1);

  static const Color dewberry900 = Color(0xFF472B4F);
  static const Color dewberry800 = Color(0xFF5E3A69);
  static const Color dewberry700 = Color(0xFF6A4176);
  static const Color dewberry600 = Color(0xFF764884);
  static const Color dewberry500 = Color(0xFF8B559B);
  static const Color dewberry400 = Color(0xFF8B559B);
  static const Color dewberry300 = Color(0xFF9861A8);
  static const Color dewberry200 = Color(0xFFA97BB7);
  static const Color dewberry100 = Color(0xFFD4BDDB);
}