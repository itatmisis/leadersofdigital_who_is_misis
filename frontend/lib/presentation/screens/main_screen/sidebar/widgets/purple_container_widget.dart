import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';
class PurpleContainer extends StatelessWidget {
  const PurpleContainer({Key? key, required this.heading, required this.subtitle}) : super(key: key);

   final String heading;
   final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.veryPeri200),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(heading, style: AppFonts.body2SemiBold.copyWith(color: AppColors.gray)),
            Text(subtitle, style: AppFonts.heading2.copyWith(color: AppColors.veryPeri500)),
          ],
        ),
      ),
    );
  }
}
