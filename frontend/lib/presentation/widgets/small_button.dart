import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmallButton extends StatelessWidget {
  final String icon;
  final Color color;
  final Function() onPressed;

  const SmallButton(
      {Key? key,
      required this.icon,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.neutralWhite),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: SvgPicture.asset(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
