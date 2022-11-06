import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/theme/app_colors.dart';

class PlusMinusWidget extends StatelessWidget {

  final Function() onPlus, onMinus;

  const PlusMinusWidget({Key? key, required this.onPlus, required this.onMinus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.white),
        child: Column(
          children: [
            GestureDetector(
              onTap: onPlus,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "assets/icons/add.svg",
                  height: 20,
                  color: AppColors.neutral800,
                ),
              ),
            ),
            GestureDetector(
              onTap: onMinus,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  "assets/icons/remove.svg",
                  height: 20,
                  color: AppColors.neutral800,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
