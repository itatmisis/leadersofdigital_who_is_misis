import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class DocumentTitle extends StatelessWidget {
  const DocumentTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.text_snippet_rounded,
                  color: AppColors.lightGray,
                ),
                SizedBox(width: 24,),
                Text(
                  title,
                  style: AppFonts.body2Medium.copyWith(color: AppColors.gray),
                ),
              ],
            ),
            const Icon(
              Icons.expand_more_rounded,
              color: AppColors.lightGray,
            ),
          ],
        ),
      ),
    );
  }
}
