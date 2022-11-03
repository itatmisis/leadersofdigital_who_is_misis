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
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: AppColors.white),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              icon,
              height: 20,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
