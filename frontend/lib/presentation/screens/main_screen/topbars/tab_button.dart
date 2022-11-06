import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class TabButton extends StatelessWidget {
  final String icon, text;
  final void Function()? onPressed;
  final bool isActive;
  final double iconSize;
  final double topPadding;

  const TabButton({super.key, required this.icon, required this.text, this.onPressed, this.iconSize = 20, this.topPadding = 10, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      color: isActive? AppColors.white : Colors.transparent,
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.only(left: 6, right: 6, top: topPadding, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(icon, color: isActive? AppColors.neutral800 : AppColors.white, height: iconSize,),
              Text(text, style: AppFonts.body2Medium.copyWith(color: isActive? AppColors.neutral800 : AppColors.white),)
            ],
          ),
        ),
      ),
    );
  }

}