import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
extension LogicSize on num {
  static const double _scaleFactor = 0.8;

  double get sc => this * _scaleFactor;
}

class AppFonts {
  static final TextStyle heading1 = TextStyle(fontSize: 32.sc, fontWeight: FontWeight.w700, color: AppColors.black);
  static final TextStyle heading2 = TextStyle(fontSize: 28.sc, fontWeight: FontWeight.w700, color: AppColors.black);
  static final TextStyle heading3 = TextStyle(fontSize: 24.sc, fontWeight: FontWeight.w500, color: AppColors.black);

  static final TextStyle subtitle1 = TextStyle(fontSize: 20.sc, fontWeight: FontWeight.w400, color: AppColors.black);
  static final TextStyle subtitle2 = TextStyle(fontSize: 18.sc, fontWeight: FontWeight.w700, color: AppColors.black);

  static final TextStyle body1SemiBold = TextStyle(fontSize: 18.sc, fontWeight: FontWeight.w600, color: AppColors.black);
  static final TextStyle body1Regular = TextStyle(fontSize: 18.sc, fontWeight: FontWeight.w500, color: AppColors.black);

  static final TextStyle body2SemiBold = TextStyle(fontSize: 16.sc, fontWeight: FontWeight.w600, color: AppColors.black);
  static final TextStyle body2Medium = TextStyle(fontSize: 16.sc, fontWeight: FontWeight.w500, color: AppColors.black);
  static final TextStyle body2Regular = TextStyle(fontSize: 16.sc, fontWeight: FontWeight.w400, color: AppColors.black);
}