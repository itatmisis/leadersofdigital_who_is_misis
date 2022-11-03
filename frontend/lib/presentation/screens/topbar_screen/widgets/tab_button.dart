import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class TabButton extends StatelessWidget {
  final String icon, text;
  final void Function()? onPressed;

  final double iconSize;
  final double topPadding;

  const TabButton({super.key, required this.icon, required this.text, this.onPressed, this.iconSize = 20, this.topPadding = 10});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: topPadding, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(icon, color: AppColors.white, height: iconSize,),
            Text(text, style: AppFonts.body2Medium.copyWith(color: AppColors.white),)
          ],
        ),
      ),
    );
  }

}