import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/theme/app_colors.dart';

class PlusMinusWidget extends StatelessWidget {
  const PlusMinusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.neutralWhite),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                "assets/icons/add.svg",
                color: AppColors.neutral800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                "assets/icons/remove.svg",
                color: AppColors.neutral800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
