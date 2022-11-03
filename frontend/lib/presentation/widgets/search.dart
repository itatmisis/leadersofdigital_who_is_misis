import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class Search extends StatelessWidget {

  final Color _backgroundColor;
  final double _elevation;

  final Function(String)? onSubmitted;

  const Search.v1({super.key, this.onSubmitted}): _backgroundColor = AppColors.white, _elevation = 3;
  const Search.v2({super.key, this.onSubmitted}): _backgroundColor = AppColors.neutral200, _elevation = 3;
  const Search.v3({super.key, this.onSubmitted}): _backgroundColor = AppColors.neutral100, _elevation = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: _elevation,
      borderRadius: BorderRadius.circular(8),
      child: TextField(
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8)),
            hintText: 'Поиск по участкам',
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 60),
            fillColor: _backgroundColor,
            hintStyle: AppFonts.body1Regular.copyWith(color: AppColors.lightGray),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 15, top: 12, bottom: 12, left: 15),
              child: SvgPicture.asset('assets/icons/search.svg', color: AppColors.neutral800, height: 20,),
            )
        ),
      ),
    );
  }

}